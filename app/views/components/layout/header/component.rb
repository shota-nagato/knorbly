# frozen_string_literal: true

class Layout::Header::Component < ApplicationViewComponent
  def render?
    helpers.authenticated?
  end
end
