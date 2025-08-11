# == Schema Information
#
# Table name: sources
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  rss_url     :string
#  slug        :string           not null
#  source_type :integer          default("rss"), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Source, type: :model do
  describe "factory" do
    subject { build(:source) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "slug" do
    before do
      create(:source, name: "source name")
    end

    context "同じ名前のソースを作成した場合" do
      it "slugに連番が振られる" do
        source = create(:source, name: "source name")
        expect(source.slug).to eq("source-name2")
      end
    end
  end
end
