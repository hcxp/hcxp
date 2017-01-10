class TeamEventsController < ApplicationController
  def index
    @team   = find_team
    @events = events_index(find_team.events)
  end

  private

  def find_team
    Team.friendly.find(params[:team_id]).decorate
  end
end