# frozen_string_literal: true

class LinkButton::Component < BaseButtonComponent
  option :path
  option :text

  style do
    variants(strategy: :extend) do
    end
  end
end
