# frozen_string_literal: true

class SubmitButton::Component < BaseButtonComponent
  option :form
  option :text

  style do
    variants(strategy: :extend) do
    end
  end
end
