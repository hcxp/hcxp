class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  impressionist actions: [:show]

  helper_method :options_for_user_teams

  # GET /venues
  # GET /venues.json
  def index
    @events = events_index(Event.includes(:venue, :bands, :user))
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    redirect_to @event.public_html_path unless params[:slugged]
  end

  def new
    authenticate_user!
    authorize Event

    event = Event.create!(status: :draft, user: current_user)
    redirect_to event_wizard_path(event)
    # @event = Event.new(beginning_at: Time.zone.now.change(hour: 19, minute: 0)).decorate
  end

  def create
    authenticate_user!
    @event = Event.new(event_params).decorate
    @event.user  = current_user
    @event.actor = current_user

    if @event.save
      redirect_to @event.public_html_path, notice: 'Event saved successfully'
    else
      render :new
    end
  end

  def edit
    authenticate_user!
    authorize @event
  end

  def update
    authenticate_user!
    authorize @event

    if @event.update_attributes(event_params.merge(actor: current_user))
      redirect_to @event.public_html_path, notice: 'Event saved successfully'
    else
      render :edit
    end
  end

  def destroy
    authenticate_user!
    authorize @event

    @event.destroy!
    redirect_to events_path, notice: 'Event successfully removed'
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    if params[:event]
      params[:event][:band_ids]     = params[:event][:band_ids].split(',').uniq if params[:event][:band_ids]
      params[:event][:beginning_at] = Delocalize::Parsers::DateTime.new(DateTime).parse(params[:event][:beginning_at]) if params[:event][:beginning_at]
    end

    params.require(:event).permit(
      :name, :price, :venue_id, :beginning_at, :ownership_type, :poster,
      :link, :team_id, :band_ids => []
    )
  end

  def options_for_user_teams
    teams = current_user.teams.map { |t| [t.name, t.id] }
    owned_teams = current_user.owned_teams.map { |t| [t.name, t.id] }

    teams + owned_teams
  end
end
