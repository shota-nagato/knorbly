require "rails_helper"

RSpec.describe "Settings::Profiles", type: :system do
  let(:user) { create(:user, name: "変更前の名前") }

  before do
    sign_in user
  end

  describe "名前自動保存" do
    context "20字以内で編集した場合" do
      it "名前を編集してフォーカスを外すと名前が自動保存される", js: true do
        visit settings_profile_path

        fill_in "user_name", with: "変更後の名前"
        # inputからフォーカスを外したことを再現する
        find("body").click

        expect(page).to have_content "名前を更新しました", wait: 3
        expect(user.reload.name).to eq "変更後の名前"
      end
    end

    context "21字以上で編集した場合" do
      it "名前を編集してフォーカスを外すと名前が自動保存されない", js: true do
        visit settings_profile_path

        fill_in "user_name", with: "a" * 21
        # inputからフォーカスを外したことを再現する
        find("body").click

        expect(page).to have_content "名前は20文字以内で入力してください", wait: 3
        expect(user.reload.name).to eq "変更前の名前"
      end
    end
  end
end
