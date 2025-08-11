class Feeds::SaveItemsJob < ApplicationJob
  queue_as :default

  def perform(saved_feed)
    response = Net::HTTP.get(URI.parse(saved_feed.rss_url))
    fetched_feed = Feedjira.parse(response)

    fetched_feed.entries.each do |item|
      saved_feed.items.find_or_create_by(
        title: item.title,
        summary: item.summary,
        url: item.url,
        image_url: item.image,
        published_at: item.published
      )
    end
  end
end
