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
        streams = []

        if @user_item_state.archived?
          streams << turbo_stream.remove(dom_id(@item, :item_card))
        else
          streams << turbo_stream.replace(
            dom_id(@item, :item_card),
            Item::Component.new(item: @item, user_item_state: @user_item_state)
          )
        end

        # フォルダの統計を更新
        @item.source.folders.each do |folder|
          streams << turbo_stream.replace(
            dom_id(folder),
            ItemStats::Component.new(folder: folder).render_in(view_context)
          )
        end

        # all_foldersの統計を更新
        streams << turbo_stream.replace(
          "all_folders",
          ItemStats::Component.new.render_in(view_context)
        )

        render turbo_stream: streams
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
