class Api::V1::EventBandsController < Api::V1Controller
  def index
    @event = Event.find(params[:event_id])
    @bands = @event.bands.page(params[:page])

    render json: @bands, adapter: :json_api
  end
end
