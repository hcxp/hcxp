class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  # @todo  Move that to service
  #
  def events_index(col = Event.all)
    col = col.search(params[:q]) if params[:q].present?

    case params[:s]
      when 'past'
        col = col.past.order(beginning_at: :desc)
      when 'all'
        col = col.order(beginning_at: :desc)
      else
        col = col.upcoming.order(beginning_at: :asc)
    end

    col = col.page(params[:page])

    col
  end

  # @todo  Move that to service
  #
  def bands_index(col = Band.all)
    col = col.search(params[:q]) if params[:q].present?
    col = col.where(id: params[:id_in]) if params[:id_in].present?
    col = col.page(params[:page])

    col
  end

  # @todo  Move that to service
  #
  def venues_index(col = Venue.all)
    col = col.search(params[:q]) if params[:q].present?
    col = col.page(params[:page])

    col
  end
end
