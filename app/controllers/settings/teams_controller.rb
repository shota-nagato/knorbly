class Settings::TeamsController < ApplicationController
  include AutoSaveable

  before_action :set_team

  def edit
  end

  def update
    handle_auto_save_update(@team, settings_team_path)
  end

  private

  def set_team
    @team = current_team
  end

  def team_params
    params.expect(team: [ :name ])
  end
end
