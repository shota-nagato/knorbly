require "rails_helper"

RSpec.describe "Dashboard", type: :system do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  context "ログインしていない場合" do
    it "ルートページに遷移できる" do
      visit root_path

      expect(page).to have_current_path root_path
    end
  end

  context "ログインしている場合" do
    before do
      sign_in user
    end

    it "ダッシュボードページにリダイレクトする" do
      visit root_path

      expect(page).to have_current_path dashboard_path
    end
  end
end
