class ItemsController < ApplicationController
  def index
    @items = current_user.visible_items.preload(:source)
  end

  def search
    items = if params[:query].blank?
      current_user.visible_items.preload(:source)
    else
      current_user.visible_items.search(params[:query]).preload(:source)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          :items_search_result,
          partial: "items/search_result",
          locals: { items: items, query: params[:query] }
        )
      end
    end
  end
end
