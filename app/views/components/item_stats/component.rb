# frozen_string_literal: true

class ItemStats::Component < ApplicationViewComponent
  option :folder, default: proc { nil }

  def sources_count
    if folder.present?
      folder.sources.count
    else
      helpers.current_team.sources.distinct.count
    end
  end

  def visible_items_count
    if folder.present?
      helpers.current_user.visible_items.merge(folder.items).count
    else
      helpers.current_user.visible_items.count
    end
  end

  def turbo_frame_id
    if folder.present?
      dom_id(folder)
    else
      "all_folders"
    end
  end
end
