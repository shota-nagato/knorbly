require "rails_helper"

RSpec.describe "Users::Passwords", type: :system do
  before do
    ActiveJob::Base.queue_adapter = :inline
    create(:user, email: "user@example.com", password: "password")
  end

  context "認証リンクが有効な場合" do
    it "パスワードを変更できる" do
      visit new_password_path

      expect do
        fill_in "email", with: "user@example.com"
        click_button "パスワードリセットのメールを送信する"

        expect(page).to have_content "パスワードリセットのメールを送信しました"
        expect(page).to have_current_path login_path
      end.to change(ActionMailer::Base.deliveries, :count).by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq [ "user@example.com" ]
      expect(mail.subject).to eq "パスワードリセット"

      reset_url = URI.extract(mail.text_part.body.to_s).first
      visit reset_url

      fill_in "password", with: "newpassword"
      fill_in "password_confirmation", with: "newpassword"
      click_button "パスワードを変更する"

      expect(page).to have_content "パスワードがリセットされました"
      expect(page).to have_current_path login_path

      fill_in "email", with: "user@example.com"
      fill_in "password", with: "newpassword"
      click_button "ログインする"

      expect(page).to have_content "ログインしました"
      expect(page).to have_current_path dashboard_path
    end
  end

  context "認証リンクが無効な場合" do
    it "パスワードを変更できない" do
      visit edit_password_url("invalid_token")

      expect(page).to have_content "パスワードリセットリンクが無効か期限切れです"
    end
  end
end
