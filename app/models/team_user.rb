# == Schema Information
#
# Table name: team_users
#
#  id         :bigint           not null, primary key
#  role       :integer          default("member"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_team_users_on_team_id  (team_id)
#  index_team_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#  fk_rails_...  (user_id => users.id)
#
class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :team_id, uniqueness: { scope: :user_id }

  enum :role, [ :member, :admin ]
end
