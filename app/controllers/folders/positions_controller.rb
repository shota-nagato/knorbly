class Folders::PositionsController < ApplicationController
  before_action :set_folder

  def update
    @folder.insert_at(position_params[:position].to_i)

    head :ok
  end

  private

  def set_folder
    @folder = current_team.folders.find_by!(slug: params[:folder_slug])
  end

  def position_params
    params.expect(folder: [ :position ])
  end
end
