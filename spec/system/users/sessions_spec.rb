require "rails_helper"

RSpec.describe "Users::Sessions", type: :system do
  before do
    create(:user, email: "user@example.com", password: "password")
  end

  context "正しいメールアドレス、パスワードを入力した場合" do
    it "ログインできる" do
      visit login_path

      fill_in "email", with: "user@example.com"
      fill_in "password", with: "password"

      expect do
        click_button "Sign in"

        expect(page).to have_current_path root_path
      end.to change(Session, :count).by(1)
    end
  end
end
