# == Schema Information
#
# Table name: source_subscriptions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  folder_id  :bigint           not null
#  source_id  :bigint           not null
#
# Indexes
#
#  index_source_subscriptions_on_folder_id_and_source_id  (folder_id,source_id) UNIQUE
#  index_source_subscriptions_on_source_id                (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (folder_id => folders.id)
#  fk_rails_...  (source_id => sources.id)
#
require 'rails_helper'

RSpec.describe SourceSubscription, type: :model do
  describe "factory" do
    subject { build(:source_subscription) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "name" do
    let(:source) { create(:source, name: "Source Title") }
    let(:folder) { create(:folder) }
    let(:folder_subscription) { create(:source_subscription, source:, folder:) }

    it "sourceのnameを返す" do
      expect(folder_subscription.name).to eq("Source Title")
    end
  end

  describe "validation" do
    let(:source) { create(:source) }
    let(:folder) { create(:folder) }
    let(:folder_subscription) { build(:source_subscription, source:, folder:) }

    before do
      create(:source_subscription, source:, folder:)
    end

    it "source_idとfolder_idの組み合わせがユニーク" do
      expect(folder_subscription).to be_invalid
    end
  end
end
