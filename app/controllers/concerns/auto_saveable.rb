# frozen_string_literal: true

module AutoSaveable
  extend ActiveSupport::Concern

  private

  def handle_auto_save_update(resource, redirect_path, notice_key = ".updated")
    respond_to do |format|
      if resource.update(send("#{resource.model_name.param_key}_params"))
        updated_attribute = resource.previous_changes.except(:updated_at).keys.last
        return unless updated_attribute

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "#{updated_attribute}-status",
            AutoSaveSuccess::Component.new(
              text: t(".attribute_updated", attribute: resource.class.human_attribute_name(updated_attribute))
            ).render_in(view_context)
          )
        end
        format.html { redirect_to redirect_path, notice: t(notice_key) }
      else
        error_attribute = resource.errors.messages.keys.last

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "#{error_attribute}-status",
            AutoSaveError::Component.new(text: resource.errors.full_messages.last).render_in(view_context)
          )
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
end
