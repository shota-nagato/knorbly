# == Schema Information
#
# Table name: folders
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  position   :integer          default(0), not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_folders_on_team_id               (team_id)
#  index_folders_on_team_id_and_position  (team_id,position) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
FactoryBot.define do
  factory :folder do
    name { "フォルダ名" }
    association :team
  end
end
