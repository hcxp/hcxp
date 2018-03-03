class Api::V1::EventsController < Api::V1Controller
  def index
    @events = Event.page(params[:page])
                   .includes(:bands)

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

    outcome = Events::AddFromFacebook.run(link: params[:link])

    if outcome.valid?
      render json: outcome.result, status: :created, adapter: :json_api
    else
      render json: outcome.errors.full_messages, status: :bad_request, adapter: :json_api
    end
  end

  def ping_view
    render json: { success: true }
  end
end
