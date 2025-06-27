class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user.present?
      PasswordsMailer.reset(user).deliver_later
      redirect_to login_path, notice: t(".sent_instructions")
    else
      redirect_to new_password_path, alert: t(".user_not_found")
    end
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to login_path, notice: t(".password_has_been_reset")
    else
      redirect_to edit_password_path(params[:token]), alert: t(".password_did_not_match")
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: t(".password_reset_link_is_invalid_or_has_expired")
    end
end
