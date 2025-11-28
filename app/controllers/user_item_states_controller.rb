# frozen_string_literal: true

class UserItemStatesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_item
  before_action :set_user_item_state

  def update
    case params[:status]
    when "read"
      @user_item_state.mark_as_read!
    when "unread"
      @user_item_state.mark_as_unread!
    when "archived"
      @user_item_state.mark_as_archived!
    end

    respond_to do |format|
      format.turbo_stream do
        if @user_item_state.archived?
          render turbo_stream: turbo_stream.remove(dom_id(@item, :item_card))
        else
          render turbo_stream: turbo_stream.replace(
            dom_id(@item, :item_card),
            Item::Component.new(item: @item, user_item_state: @user_item_state)
          )
        end
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_user_item_state
    @user_item_state = current_user.user_item_states.find_or_create_by!(item: @item)
  end
end
