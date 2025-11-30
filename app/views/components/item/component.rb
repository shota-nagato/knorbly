# frozen_string_literal: true

class Item::Component < ApplicationViewComponent
  option :item
  option :user_item_state

  with_collection_parameter :item
end
