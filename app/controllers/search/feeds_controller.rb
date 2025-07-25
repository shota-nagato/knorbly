class Search::FeedsController < ApplicationController
  def index
  end

  def search
    feeds = Source.rss.search(params[:query])

    respond_to do |format|
      format.turbo_stream do
        if params[:query].blank?
          render turbo_stream: turbo_stream.update(:search_result)
        else
          render turbo_stream: turbo_stream.update(
            :search_result,
            partial: "search/feeds/search_result",
            locals: { feeds: feeds }
          )
        end
      end
    end
  end
end
