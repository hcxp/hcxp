class FeedsController < ApplicationController
  respond_to :atom

  def newsletter
    @events = Event.order(beginning_at: :asc)
                   .includes(:bands, :venue)

    @events = @events.where('beginning_at >= ?', Time.zone.now.beginning_of_week + 1.week)
                     .where('beginning_at < ?',  Time.zone.now.end_of_week + 1.week)

    @events = @events.limit(25)
  end
end