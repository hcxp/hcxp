class TeamEventsController < ApplicationController
  def index
    @team = find_team
    @events = find_events
  end

  private

  def find_events
    find_team.events.includes(:user, :bands, :venue).page(params[:page])
  end

  def find_team
    Team.find(params[:team_id]).decorate
  end
end