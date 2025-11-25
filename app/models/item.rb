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
class Item < ApplicationRecord
  belongs_to :source, optional: true

  has_many :user_item_states, dependent: :destroy
  has_many :users, through: :user_item_states

  validates :title, :url, presence: true
  validates :url, uniqueness: true

  def self.search(query)
    return none if query.blank?

    where(arel_table[:title].matches("%#{sanitize_sql_like(query)}%"))
      .or(where(arel_table[:summary].matches("%#{sanitize_sql_like(query)}%")))
  end
end
