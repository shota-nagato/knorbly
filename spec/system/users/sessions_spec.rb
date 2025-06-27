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
        click_button "ログインする"

        expect(page).to have_current_path dashboard_path
      end.to change(Session, :count).by(1)
    end

    context "誤ったメールアドレスを入力した場合" do
      it "ログインできない" do
        visit login_path

        fill_in "email", with: "invalid@example.com"
        fill_in "password", with: "password"

        click_button "ログインする"

        expect(page).to have_current_path login_path
      end
    end
  end
end
