# frozen_string_literal: true

class Toast::Component < ApplicationViewComponent
  option :message
  option :type, default: proc { :notice }

  def base_style
    "flex items-center gap-2 fixed top-4 right-4 z-50 py-2 px-4 shadow-sm border border-border transition-opacity duration-300 transform rounded-md"
  end

  def text_color
    case type.to_sym
    when :notice
      "text-secondary"
    when :alert
      "text-alert"
    end
  end

  def icon_color
    case type.to_sym
    when :notice
      "text-primary"
    when :alert
      "text-alert"
    end
  end

  def background_color
    case type.to_sym
    when :notice
      "bg-white"
    when :alert
      "bg-alert/10"
    end
  end

  def icon_name
    case type.to_sym
    when :notice
      "check-circle"
    when :alert
      "exclamation-circle"
    end
  end
end
