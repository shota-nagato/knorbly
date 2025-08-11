# == Schema Information
#
# Table name: items
#
#  id           :bigint           not null, primary key
#  image_url    :string
#  published_at :datetime
#  summary      :string
#  title        :string           not null
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  source_id    :bigint
#
# Indexes
#
#  index_items_on_source_id  (source_id)
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "factory" do
    subject { build(:item) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end
end
