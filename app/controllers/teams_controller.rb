class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :edit_users, :invite_user, :remove_user, :update]

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

  def edit
    authenticate_user!
    authorize @team
  end

  def edit_users
    authenticate_user!
    authorize @team

    @team_users = @team.team_users
    @team_user  = TeamUser.new(team: @team)
  end

  def invite_user
    authenticate_user!
    authorize @team

    @team_users = @team.team_users
    user        = User.find_by(username: team_user_params[:username])
    @team_user  = TeamUser.new(team: @team, user: user, username: team_user_params[:username])

    if @team_user.save
      redirect_to :back, notice: 'User successfully invited!'
    else

      if !user.present?
        @team_user.errors.clear
        @team_user.errors.add(:username, 'not found')
      end

      render :edit_users
    end
  end

  def remove_user
    authenticate_user!
    authorize @team

    team_user = @team.team_users.find(params[:team_user_id])
    team_user.destroy!

    redirect_to edit_users_team_path(@team), notice: 'User successfully removed.'
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

  def team_user_params
    params.require(:team_user).permit(:username)
  end
end
