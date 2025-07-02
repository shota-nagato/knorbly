# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_teams_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users

  validates :name, presence: true
end
