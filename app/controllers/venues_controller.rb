class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = venues_index(Venue.includes(:events))
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @events = events_index(@venue.events)
  end

  def create
    authenticate_user!
    @venue = Venue.new(venue_params)
    @venue.user_id = current_user.id

    if @venue.save
      render @venue, status: :created, location: @venue
    else
      render json: { errors: @venue.errors, full_error_messages: @venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.friendly.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:name, :address)
  end
end
