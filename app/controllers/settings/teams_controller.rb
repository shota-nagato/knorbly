class Settings::TeamsController < ApplicationController
  before_action :set_team

  def edit
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        updated_attribute = @team.previous_changes.except(:updated_at).keys.last
        return unless updated_attribute

        format.turbo_stream {
          render turbo_stream: turbo_stream.update(
            "#{updated_attribute}-status",
            AutoSaveSuccess::Component.new(text: t(".attribute_updated", attribute: Team.human_attribute_name(updated_attribute))).render_in(view_context))
        }
        format.html { redirect_to settings_team_path, notice: t(".updated") }
      else
        error_attribute =  @team.errors.messages.keys.last

        format.turbo_stream {
          render turbo_stream: turbo_stream.update(
            "#{error_attribute}-status",
            AutoSaveError::Component.new(text: @team.errors.full_messages.last).render_in(view_context))
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_team
    @team = current_team
  end

  def team_params
    params.expect(team: [ :name ])
  end
end
