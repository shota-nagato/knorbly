class Settings::ProfilesController < ApplicationController
  before_action :set_user

  def edit
  end

  # autosaveアクションに移行するかも
  def update
    respond_to do |format|
      if @user.update(user_params)
        updated_attribute = @user.previous_changes.keys.last
        return unless updated_attribute

        format.turbo_stream {
          render turbo_stream: turbo_stream.update(
            "#{updated_attribute}-status",
            AutoSaveSuccess::Component.new(text: "#{User.human_attribute_name(updated_attribute)}を更新しました").render_in(view_context))
        }
        format.html { redirect_to settings_profile_path, notice: "プロフィールを更新しました" }
      else
        error_attribute =  @user.errors.messages.keys.last

        format.turbo_stream {
          render turbo_stream: turbo_stream.update(
            "#{error_attribute}-status",
            AutoSaveError::Component.new(text: @user.errors.full_messages.last).render_in(view_context))
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.expect(user: [ :name, :email, :password, :password_confirmation ])
  end
end
