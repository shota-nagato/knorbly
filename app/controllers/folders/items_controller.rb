class Folders::ItemsController < ApplicationController
  before_action :set_folder

  def search
    items = if params[:query].blank?
      current_user.visible_items.merge(@folder.items).preload(:source)
    else
      current_user.visible_items.merge(@folder.items).search(params[:query]).preload(:source)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          :items_search_result,
          partial: "folders/items/search_result",
          locals: { items: items, query: params[:query] }
        )
      end
    end
  end

  private

  def set_folder
    @folder = current_team.folders.find_by(slug: params[:folder_slug])
  end
end
