class BandCardCell < Cell::ViewModel

  def show
    render
  end

  private

  def poster_events
    model.events.limit(4)
  end

end
