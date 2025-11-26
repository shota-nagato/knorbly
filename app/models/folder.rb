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
class Folder < ApplicationRecord
  include Sluggable

  sluggable :name, scope: :team_id

  belongs_to :team

  acts_as_list scope: :team_id, sequential_updates: true

  has_many :source_subscriptions, dependent: :destroy
  has_many :sources, through: :source_subscriptions
  has_many :items, through: :sources

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :team_id }

  def subscribe?(source)
    sources.include?(source)
  end

  def subscribe!(source)
    source_subscriptions.create!(source: source)

    SaveUserItemStatesJob.perform_later(team, source)
  end

  def unsubscribe!(source)
    source_subscriptions.find_by!(source: source).destroy!

    # TODO: user_item_statesをこの時点で削除するか、バッチ処理で削除するか検討する
  end
end
