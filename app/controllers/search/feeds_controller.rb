class Search::FeedsController < ApplicationController
  include UrlValidation

  def index
  end

  def show
    @feed = Source.rss.find_by(slug: params[:slug])

    # TODO: source保存時にarticlesも保存しておく
    response = Net::HTTP.get(URI.parse(@feed.rss_url))
    @articles = Feedjira.parse(response).entries
  end

  def search
    feeds = if valid_url?(params[:query])
      feed = Source.fetch_and_save_feed(params[:query])
      feed ? [ feed ] : []
    else
      Source.rss.search(params[:query])
    end

    feeds_count = feeds.count

    respond_to do |format|
      format.turbo_stream do
        if params[:query].blank?
          render turbo_stream: turbo_stream.update(:search_result)
        else
          render turbo_stream: turbo_stream.update(
            :search_result,
            partial: "search/feeds/search_result",
            locals: { feeds: feeds_count > 5 ? feeds.limit(5) : feeds, feed_count: feeds_count }
          )
        end
      end
    end
  end

  def list
    redirect_to search_feeds_path if params[:query].blank?

    @feeds = Source.rss.search(params[:query])
  end
end
