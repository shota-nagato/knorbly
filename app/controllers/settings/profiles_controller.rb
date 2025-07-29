class Settings::ProfilesController < ApplicationController
  include AutoSaveable

  before_action :set_user

  def edit
  end

  # autosaveアクションに移行するかも
  def update
    handle_auto_save_update(@user, settings_profile_path)
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.expect(user: [ :name, :email, :password, :password_confirmation ])
  end
end
