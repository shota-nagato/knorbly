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
require "net/http"

class Source < ApplicationRecord
  include Sluggable

  sluggable :name

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :rss_url, presence: true, uniqueness: true, if: :rss_url_required?

  enum :source_type, [ :rss ]

  def self.search(query)
    return [] if query.blank?

    where(arel_table[:name].matches("%#{sanitize_sql_like(query)}%"))
  end

  def rss_url_required?
    rss?
  end

  def self.fetch_and_save_feed(url)
    response = Net::HTTP.get(URI.parse(url))

    parsed_data = Feedjira.parse(response)

    feed = Source.rss.find_or_initialize_by(rss_url: url)

    if feed.new_record?
      feed.url = parsed_data.url
      feed.name = parsed_data.title
      feed.description = parsed_data.description
      feed.save!
    end

    feed
  rescue => e
    nil
  end
end
