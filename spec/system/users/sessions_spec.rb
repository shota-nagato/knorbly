require "rails_helper"

RSpec.describe "Users::Sessions", type: :system do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  describe "ログイン" do
    context "正しいメールアドレス、パスワードを入力した場合" do
      it "ログインできる", js: true do
        visit login_path

        fill_in "email", with: user.email
        fill_in "password", with: "password"

        expect do
          click_button "ログインする"

          expect(page).to have_content "ログインしました"
          expect(page).to have_current_path dashboard_path
        end.to change(Session, :count).by(1)
      end
    end

    context "誤ったメールアドレスを入力した場合" do
      it "ログインできない" do
        visit login_path

        fill_in "email", with: "invalid@example.com"
        fill_in "password", with: "password"

        click_button "ログインする"

        expect(page).to have_content "別のメールアドレスかパスワードを試してください"
        expect(page).to have_current_path login_path
      end
    end

    context "誤ったパスワードを入力した場合" do
      it "ログインできない" do
        visit login_path

        fill_in "email", with: user.email
        fill_in "password", with: "invalid"

        click_button "ログインする"

        expect(page).to have_content "別のメールアドレスかパスワードを試してください"
        expect(page).to have_current_path login_path
      end
    end
  end

  describe "ログアウト" do
    it "ログアウトできる" do
      sign_in user

      visit dashboard_path

      click_button "Sign out"

      expect(page).to have_content "ログアウトしました"
      expect(page).to have_current_path login_path
    end
  end
end
