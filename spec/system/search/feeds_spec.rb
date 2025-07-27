require "rails_helper"

RSpec.describe "Search::Feeds", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  context "フィードが存在する場合" do
    before do
      create(:source, name: "フィード1", description: "フィード1の説明")
    end

    it "フィードを検索できる", js: true do
      visit search_feeds_path

      fill_in "query", with: "フィード1"

      expect(page).to have_content "1件見つかりました"
      expect(page).to have_content "フィード1の説明"
    end
  end

  context "フィードが存在しない場合" do
    it "「見つかりませんでしたが」表示される", js: true do
      visit search_feeds_path

      fill_in "query", with: "フィード1"

      expect(page).to have_content "見つかりませんでした"
    end
  end
end
