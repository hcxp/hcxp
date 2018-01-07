class SyncEventFacebookDataJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    @event = Event.find(event_id)

    @event.update_attributes(
      state:        'ready',
      name:         facebook_event['name'],
      description:  facebook_event['description'],
      start_at:     facebook_event['start_time'],
      poster_url:   facebook_event['cover']['source'],
      place_name:   facebook_event['place']['name'],
      nominatim_place_id: geocoded_place.place_id,
      city:         city_from_geocoded_place,
      country_code: geocoded_place.address.country_code,
      latitude:     geocoded_place.lat,
      longitude:    geocoded_place.lon,
    )

    ActionCable.server.broadcast 'events', {
      key: 'updated',
      data: ActiveModel::SerializableResource.new(@event, adapter: :json_api)
                                             .serializable_hash[:data]
    }
  end

  private

  attr_reader :event, :geocoded_place

  def graph
    logger.debug 'Initializing graph client'

    token = Rails.cache.fetch('facebook_token', expires_in: 40.minutes) do
      oauth = Koala::Facebook::OAuth.new(
        ENV['FACEBOOK_APP_ID'],
        ENV['FACEBOOK_APP_SECRET'],
        'http://localhost:3000/admin/fbwall'
      )
      oauth.get_app_access_token
    end

    @graph ||= Koala::Facebook::API.new(token)
  end

  def facebook_event
    @facebook_event ||= graph.get_connection(
      event.facebook_event_id,
      '?fields=id,name,description,attending_count,start_time,place{name,location{city,country}},cover'
    )
  end

  def geocoded_place
    @geocoded_place ||= GeocodeFacebookPlace.run!(place: facebook_event['place'])
  end

  # If village is set, use a village name. Otherwise - use original city name
  # (in a language native to place country)
  def city_from_geocoded_place
    geocoded_place.address.village.present? \
      ? geocoded_place.address.village
      : geocoded_place.name_details[:name]
  end
end
