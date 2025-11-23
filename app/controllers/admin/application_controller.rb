class Admin::ApplicationController < ApplicationController
  before_action :require_admin_authentication

  layout "layouts/admin/application"

  private

  def require_admin_authentication
    raise ActionController::RoutingError, "No route matches [GET] /admin" unless current_user.admin?
  end
end
