# == Schema Information
#
# Table name: user_item_states
#
#  id          :bigint           not null, primary key
#  archived_at :datetime
#  read_at     :datetime
#  status      :integer          default("unread"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_user_item_states_on_item_id              (item_id)
#  index_user_item_states_on_user_id_and_item_id  (user_id,item_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserItemState, type: :model do
  describe "factory" do
    subject { build(:user_item_state) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "validation" do
    let(:item) { create(:item) }
    let(:user) { create(:user) }
    let(:user_item_state) { build(:user_item_state, item:, user:) }

    before do
      create(:user_item_state, item:, user:)
    end

    it "source_idとfolder_idの組み合わせがユニーク" do
      expect(user_item_state).to be_invalid
    end
  end
end
