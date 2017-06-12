class VenuesIndexService
  def initialize(col = Venue.all, params = {})
    @col    = col
    @params = params
  end

  def call
    venues = @col
    venues = venues.search(@params[:query]) if @params[:query].present?

    venues
  end
end
