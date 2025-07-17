# frozen_string_literal: true

class Button::Component < ApplicationViewComponent
  option :variant, default: proc { :default }
  option :size, default: proc { :default }
  option :disabled, default: proc { false }
  option :class_name, default: proc { "" }
  option :href, default: proc { nil }
  option :type, default: proc { "" }

  style do
    base {
      %w[relative inline-flex items-center justify-center whitespace-nowrap rounded text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-focus-ring disabled:pointer-events-none disabled:opacity-50]
    }
    variants {
      variant {
        default {
          %w[bg-primary text-primary-foreground shadow hover:bg-primary/80 focus-visible:ring-primary]
        }
        outline {
          %w[border border-border bg-background shadow-sm hover:bg-background-muted focus-visible:ring-border-focus]
        }
        destructive {
          %w[bg-alert text-alert-foreground shadow-sm hover:bg-alert/80 focus-visible:ring-alert]
        }
        secondary {
          %w[bg-secondary text-secondary-foreground shadow-sm hover:bg-secondary/80 focus-visible:ring-secondary]
        }
        ghost {
          %w[hover:bg-object-inactive hover:text-text-primary focus-visible:ring-focus-ring]
        }
        link {
          %w[text-primary underline-offset-4 hover:underline focus-visible:ring-focus-ring]
        }
      }
      size {
        default {
          %w[h-9 px-4]
        }
        sm {
          %w[h-8 px-3]
        }
        lg {
          %w[h-10 px-8]
        }
        icon {
          "size-9"
        }
      }
      disabled {
        yes { %w[opacity-50 pointer-events-none] }
      }
    }
  end

  def tag
    @href ? :a : :button
  end

  def html_options
    options = { class: tw_merge(style(variant:, size:, disabled:), class_name) }
    options[:type] = @type unless @href
    options[:href] = @href if @href
    options
  end
end
