# frozen_string_literal: true

class Dropdown::Component < ApplicationViewComponent
  renders_one :button
  renders_one :menu

  option :direction, default: proc { :bottom }

  def direction_class
    case direction
    when :bottom
      "origin-bottom-right right-0"
    when :right
      "origin-bottom-right left-full bottom-0"
    else
      "origin-bottom-right right-0"
    end
  end
end
