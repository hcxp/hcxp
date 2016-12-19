class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /venues/1
  # GET /venues/1.json
  def show
    @events = events_index(@user.owned_events)
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(username: params[:username]).decorate
  end
end
