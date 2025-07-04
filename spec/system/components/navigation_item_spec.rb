# frozen_string_literal: true

require "rails_helper"

describe "navigation_item component" do
  it "default preview" do
    visit("/rails/view_components/navigation_item/default")

    # is_expected.to have_text "Hello!"
    # click_on "Click me"
    # is_expected.to have_text "Good-bye!"
  end
end
