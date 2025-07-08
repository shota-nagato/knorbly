require "rails_helper"

RSpec.describe "Users::Registrations", type: :system do
  it "新規登録できる" do
    visit signup_path

    fill_in "user_email", with: "user@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"

    expect do
      click_button "登録する"

      expect(page).to have_content "ユーザー登録しました"
      expect(page).to have_current_path dashboard_path
    end.to change(User, :count).by(1).and change(Team, :count).by(1)
  end
end
