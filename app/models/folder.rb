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

    user_ids = team.users.ids
    items_ids = source.items.ids

    attributes = user_ids.product(items_ids).map do |user_id, item_id|
      {
        user_id: user_id,
        item_id: item_id
      }
    end

    UserItemState.insert_all(attributes) if attributes.present?
  end

  def unsubscribe!(source)
    source_subscriptions.find_by!(source: source).destroy!
  end
end
