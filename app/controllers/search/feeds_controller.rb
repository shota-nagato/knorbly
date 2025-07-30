class Search::FeedsController < ApplicationController
  before_action :set_feeds, only: [ :search, :list ]

  def index
  end

  def show
    @feed = Source.rss.find_by(slug: params[:slug])
  end

  def search
    respond_to do |format|
      format.turbo_stream do
        if params[:query].blank?
          render turbo_stream: turbo_stream.update(:search_result)
        else
          render turbo_stream: turbo_stream.update(
            :search_result,
            partial: "search/feeds/search_result",
            locals: { feeds: @feeds }
          )
        end
      end
    end
  end

  def list
    redirect_to search_feeds_path if params[:query].blank?
  end

  private

  def set_feeds
    @feeds = Source.rss.search(params[:query])
  end
end
