require "rails_helper"

RSpec.describe "source_subscriptions", type: :system do
  let(:user) { create(:user) }
  let(:source) { create(:source, name: "サンプルフィード", url: "https://example.com/feed") }

  before do
    create(:folder, name: "プログラミング", team: user.teams.last)
  end

  context "ログインしていない場合" do
    it "アクセスできない" do
      visit search_feed_path(source)

      expect(page).to have_current_path login_path
    end
  end

  context "ログインしている場合" do
    before do
      sign_in user
    end

    describe "フィード購読" do
      it "フォルダごとにフィードを購読できる" do
        visit search_feed_path(source)

        find("#feed-subscription-dropdown-button").click

        expect do
          click_link "フォロー"

          expect(page).to have_content "解除"
        end.to change(SourceSubscription, :count).by(1)
      end
    end
  end
end
