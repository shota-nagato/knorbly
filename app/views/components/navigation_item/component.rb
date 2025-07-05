# frozen_string_literal: true

class NavigationItem::Component < ApplicationViewComponent
  option :icon, default: proc { :default }
  option :text, default: proc { :default }
  option :path, default: proc { false }
end
