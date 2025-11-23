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
FactoryBot.define do
  factory :user_item_state do
    association :item
    association :user
  end
end
