class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create omniauth ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    redirect_to dashboard_path if authenticated?
  end

  def create
    if user = User.authenticate_by(params.permit(:email, :password))
      start_new_session_for user
      redirect_to after_authentication_url, notice: t(".logged_in")
    else
      redirect_to login_path, alert: t(".try_another_email_or_password")
    end
  end

  def destroy
    terminate_session
    redirect_to login_path, notice: t(".logged_out")
  end

  def omniauth
    if user = User.from_omniauth(request.env["omniauth.auth"])
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Signed in successfully"
    else
      redirect_to login_path, alert: "Authentication failed"
    end
  end
end
