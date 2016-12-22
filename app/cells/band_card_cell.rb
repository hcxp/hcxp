class BandCardCell < ApplicationCell

  def show
    render
  end

  private

  def poster_events
    model.events.order(beginning_at: :asc).limit(4)
  end

end
