class Settings::ProfilesController < ApplicationController
  before_action :set_user

  def edit
  end

  # autosaveアクションに移行するかも
  def update
    AutoSaveUpdateUsecase.new(
      controller: self,
      resource: @user,
      redirect_path: settings_profile_path
    ).call
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.expect(user: [ :name, :email, :password, :password_confirmation ])
  end
end
