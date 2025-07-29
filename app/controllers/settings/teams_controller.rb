class Settings::TeamsController < ApplicationController
  before_action :set_team

  def edit
  end

  def update
    AutoSaveUpdateUsecase.new(
      controller: self,
      resource: @team,
      redirect_path: settings_team_path
    ).call
  end

  private

  def set_team
    @team = current_team
  end

  def team_params
    params.expect(team: [ :name ])
  end
end
