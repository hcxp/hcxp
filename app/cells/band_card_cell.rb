class BandCardCell < Cell::ViewModel

  def show
    render
  end

  private

  def poster_events
    model.events.order(beginnign_at: :asc).limit(4)
  end

end
