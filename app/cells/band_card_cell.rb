class BandCardCell < Cell::ViewModel

  def show
    render
  end

  private

  def poster_events
    model.events.limit(3)
  end

end
