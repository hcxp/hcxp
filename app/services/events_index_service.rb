class EventsIndexService
  def initialize(col = Event.all, params = {})
    @col    = col
    @params = params
  end

  def call
    events = @col.includes(:bands, :venue)
    events = events.search(@params[:q]) if @params[:q].present?
    events = events.with_poster if @params[:with_poster]

    case @params[:s]
      when 'past'
        events = events.past.order(beginning_at: :desc)
      when 'all'
        events = events.order(beginning_at: :desc)
      else
        events = events.upcoming.order(beginning_at: :asc)
    end

    events
  end
end