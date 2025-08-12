require 'rails_helper'

RSpec.describe Feeds::SaveItemsJob, type: :job do
  describe "#perform" do
    let(:url) { "https://example.com/feed" }
    let(:source) { create(:source, rss_url: url) }
    let(:content) { File.read("spec/fixtures/files/rss_feed.xml") }

    before do
      stub_request(:get, url).to_return(status: 200, body: content, headers: { "Content-Type" => "application/rss+xml" })
    end

    it "フィードの記事を保存できる" do
      expect do
        Feeds::SaveItemsJob.perform_now(source)
      end.to change(Item, :count).by(2)
    end
  end
end
