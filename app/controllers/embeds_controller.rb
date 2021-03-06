class EmbedsController < ApplicationController

  after_action :allow_iframe

  layout 'embed'

  def horizontal
    @events = events_index(Event.includes(:venue, :bands, :user))

    @poster_width     = params[:poster_width] || 150
    @poster_height    = params[:poster_height] || 150
    @accent_color     = params[:accent_color] || '#e45735'
    @background_color = params[:background_color] || '#ffffff'

    @disable_horizontal_scroll = params[:disable_horizontal_scroll].present?
    @disable_vertical_scroll   = params[:disable_vertical_scroll].present?
  end

  private

  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end

end