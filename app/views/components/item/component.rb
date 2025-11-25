# frozen_string_literal: true

class Item::Component < ApplicationViewComponent
  option :item

  with_collection_parameter :item
end
