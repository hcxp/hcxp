class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @events = events_index(Event.includes(:venue, :bands, :user))
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  def new
    authenticate_user!
    authorize Event
    @event = Event.new(beginning_at: Time.zone.now).decorate
  end

  def create
    authenticate_user!
    @event = Event.new(event_params).decorate
    @event.user = current_user

    if @event.save
      redirect_to @event, notice: 'Event saved successfully'
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

    if @event.update_attributes(event_params)
      redirect_to @event, notice: 'Event saved successfully'
    else
      render :edit
    end
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params[:event][:band_ids] = params[:event][:band_ids].split(',').uniq if params[:event] && params[:event][:band_ids]

    params.require(:event).permit(
      :name, :price, :venue_id, :beginning_at, :ownership_type, :poster, :band_ids => []
    )
  end
end
