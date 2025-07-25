# == Schema Information
#
# Table name: sources
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  rss_url     :string
#  slug        :string           not null
#  source_type :integer          default(0), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Source < ApplicationRecord
  include Sluggable

  sluggable :name

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :rss_url, presence: true, if: :rss_url_required?

  enum :source_type, [ :rss ]

  def rss_url_required?
    rss?
  end
end
