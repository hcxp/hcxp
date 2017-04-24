class Api::V1::BandablesController < Api::V1Controller
  before_action :set_event

  def index
    @bandables = @event.bandables.includes(:band)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

end