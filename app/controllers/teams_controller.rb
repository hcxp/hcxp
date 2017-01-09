class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update]

  # GET /venues
  # GET /venues.json
  def index
    @teams = teams_index(Team.all)
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    # @events = events_index(@venue.events)
    @posts = @team.posts
  end

  def new
    @team = Team.new
  end

  def create
    authenticate_user!
    @team = Team.new(team_params)
    @team.user_id = current_user.id

    if @team.save
      redirect_to @team, status: :created, location: @team
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authenticate_user!
    authorize @team

    if @team.update_attributes(team_params)
      redirect_to @team, notice: 'Team saved successfully'
    else
      render :edit
    end
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :website, :description, :slug)
  end
end
