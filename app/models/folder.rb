# == Schema Information
#
# Table name: folders
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_folders_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class Folder < ApplicationRecord
  include Sluggable

  sluggable :name, scope: :team_id

  belongs_to :team

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :team_id }
end
