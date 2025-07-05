# frozen_string_literal: true

class Layout::Sidebar::Component < ApplicationViewComponent
  def render?
    helpers.authenticated?
  end

  def component_name
    request.path.start_with?("/settings") ? "layout/sidebar_settings" : "layout/sidebar_app"
  end
end
