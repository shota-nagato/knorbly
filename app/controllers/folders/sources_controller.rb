class Folders::SourcesController < ApplicationController
  before_action :set_folder

  def index
    @sources = @folder.sources
  end

  private

  def set_folder
    @folder = current_team.folders.find_by(slug: params[:folder_slug])
  end
end
