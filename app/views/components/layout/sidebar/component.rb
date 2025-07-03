# frozen_string_literal: true

class Layout::Sidebar::Component < ApplicationViewComponent
  def render?
    helpers.authenticated?
  end
end
