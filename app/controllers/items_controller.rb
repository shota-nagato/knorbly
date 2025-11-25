class ItemsController < ApplicationController
  def index
    @items = current_user.visible_items.preload(:source)
  end
end
