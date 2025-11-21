class SourceSubscriptionsController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @source = Source.find_by(slug: params[:source_id])

    folder = current_team.folders.find(params[:folder_id])

    if folder.subscribe?(@source)
      folder.unsubscribe!(@source)
    else
      folder.subscribe!(@source)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(dom_id(@source, folder.id), partial: "controllers/source_subscriptions/button", locals: { source: @source, folder: folder })
      end
    end
  end
end
