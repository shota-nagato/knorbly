require 'rails_helper'

RSpec.describe "Static", type: :system do
  describe "トップページ" do
    it "トップページを表示できる", js: true do
      visit root_path
      expect(page).to have_current_path(root_path)
    end
  end
end
