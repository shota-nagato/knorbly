require "rails_helper"

RSpec.describe "Folders", type: :system do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  before do
    sign_in user
  end

  describe "新規作成" do
    context "必須項目を入力する場合" do
      it "teamにひもづくフォルダを作成できる" do
        visit dashboard_path

        click_on "フォルダ作成"

        expect(page).to have_content "フォルダを作成"

        fill_in "folder_name", with: "テストフォルダ"

        expect do
          click_on "作成する"

          expect(page).to have_content "フォルダを作成しました"
        end.to change(user.teams.last.folders, :count).by(1)
      end
    end

    context "必須項目を入力しない場合" do
      it "フォルダを作成できない" do
        visit dashboard_path

        click_on "フォルダ作成"

        expect(page).to have_content "フォルダを作成"

        expect do
          click_on "作成する"

          expect(page).to have_content "フォルダ名を入力してください"
        end.to change(user.teams.last.folders, :count).by(0)
      end
    end
  end
end
