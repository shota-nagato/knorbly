require "rails_helper"

RSpec.describe "Search::Feeds", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "テキスト検索" do
    context "フィードが存在する場合" do
      before do
        create(:source, name: "フィード1", description: "フィード1の説明")
      end

      it "フィードを検索できる", js: true do
        visit search_feeds_path

        fill_in "query", with: "フィード1"

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

  describe "URL検索" do
    let(:url) { "https://example.com/feed" }
    let(:content) { File.read("spec/fixtures/files/rss_feed.xml") }

    before do
      stub_request(:get, url).to_return(status: 200, body: content, headers: { "Content-Type" => "application/rss+xml" })
    end

    it "URLで検索してDBにない場合は保存される", js: true do
      visit search_feeds_path

      expect do
        fill_in "query", with: url

        expect(page).to have_content "サンプルフィード"
        expect(page).to have_content "これはサンプルフィードです"
      end.to change(Source, :count).by(1)

      fill_in "query", with: "サンプル"
      expect(page).to have_content "これはサンプルフィードです"
    end
  end
end
