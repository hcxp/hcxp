class Api::V1::EventsController < Api::V1Controller
  def index
    @events = Event.page(params[:page])

    @events = params[:s] == 'past' ? @events.past : @events.upcoming.upcoming_first
    @events = @events.search(params[:q]) if params[:q].present?

    render json: @events, adapter: :json_api
  end

  def show
    @event = Event.find(params[:id])

    render json: @event, adapter: :json_api
  end

  def create
    authenticate_user!

    @output = Events::AddFromFacebook.new(params[:link])

    if @output.valid?
      @output.execute!
      render json: @output.event, status: :created
    else
      render json: @output.event, status: :bad_request
    end
  end
end
