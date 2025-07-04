class ApplicationController < ActionController::Base
  include Authentication
  include CurrentHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  append_view_path Rails.root.join("app", "views", "controllers")
end
