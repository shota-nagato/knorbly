# frozen_string_literal: true

class AutoSaveUpdateUsecase
  def initialize(controller:, resource:, redirect_path:, notice_key: ".updated")
    @controller = controller
    @resource = resource
    @redirect_path = redirect_path
    @notice_key = notice_key
  end

  def call
    controller.respond_to do |format|
      if update_resource
        handle_success(format)
      else
        handle_error(format)
      end
    end
  end

  private

  attr_reader :controller, :resource, :redirect_path, :notice_key

  def update_resource
    resource.update(controller.send("#{resource.model_name.param_key}_params"))
  end

  def handle_success(format)
    updated_attribute = resource.previous_changes.except(:updated_at).keys.last
    return unless updated_attribute

    format.turbo_stream do
      controller.render turbo_stream: controller.helpers.turbo_stream.update(
        "#{updated_attribute}-status",
        AutoSaveSuccess::Component.new(
          text: controller.t(".attribute_updated", attribute: resource.class.human_attribute_name(updated_attribute))
        ).render_in(controller.view_context)
      )
    end
    format.html { controller.redirect_to redirect_path, notice: controller.t(notice_key) }
  end

  def handle_error(format)
    error_attribute = resource.errors.messages.keys.last

    format.turbo_stream do
      controller.render turbo_stream: controller.helpers.turbo_stream.update(
        "#{error_attribute}-status",
        AutoSaveError::Component.new(text: resource.errors.full_messages.last).render_in(controller.view_context)
      )
    end
    format.html { controller.render :edit, status: :unprocessable_entity }
  end
end
