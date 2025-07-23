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

  describe "編集" do
    let(:folder) { create(:folder, name: "編集前のフォルダ", team: user.teams.last) }

    it "フォルダを編集できる" do
      visit folder_path(folder)

      expect(page).to have_content "編集前のフォルダ"

      find("#dropdown-button").click

      expect(page).to have_content "編集"

      click_on "編集"

      expect(page).to have_content "フォルダを編集"

      fill_in "folder_name", with: "編集後のフォルダ"

      expect do
        click_on "更新する"

        expect(page).to have_content "フォルダを更新しました"
      end.to change { folder.reload.name }.from("編集前のフォルダ").to("編集後のフォルダ")
    end
  end

  describe "削除" do
    let(:folder) { create(:folder, team: user.teams.last) }

    it "フォルダを削除できる" do
      visit folder_path(folder)

      find("#dropdown-button").click

      expect(page).to have_content "削除"

      expect do
        click_on "削除"

        expect(page).to have_content "フォルダを削除しました"
      end.to change(user.teams.last.folders, :count).by(-1)
    end
  end
end
