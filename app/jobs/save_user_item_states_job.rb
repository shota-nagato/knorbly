class SaveUserItemStatesJob < ApplicationJob
  queue_as :default

  def perform(team, source)
    user_ids = team.users.ids
    items_ids = source.items.ids

    attributes = user_ids.product(items_ids).map do |user_id, item_id|
      {
        user_id: user_id,
        item_id: item_id
      }
    end

    UserItemState.insert_all(attributes) if attributes.present?
  end
end
