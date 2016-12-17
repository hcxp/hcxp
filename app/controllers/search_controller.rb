class SearchController < ApplicationController
  def index
    @events = Event.search(params[:q]).page(1).per(10)
    @bands  = Band.search(params[:q]).page(1).per(2)
    @venues = Venue.search(params[:q]).page(1).per(2)
  end
end
