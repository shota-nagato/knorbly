# frozen_string_literal: true

class Input::Component < ApplicationViewComponent
  option :form
  option :label, default: proc { "" }
  option :field_type, default: proc { :text_field }
  option :attribute_key
  option :placeholder, default: proc { "" }
  option :size, default: proc { :default }
  option :class_name, default: proc { "" }

  style do
    base {
      %w[flex w-full rounded border border-border shadow-sm focus:border-border-focus focus-visible:outline-none]
    }
    variants {
      size {
        default {
          %w[h-10 px-3 py-1.5]
        }
        sm {
          %w[h-8 px-2 py-1]
        }
        lg {
          %w[h-12 px-4 py-2]
        }
      }
    }
  end
end
