class GeocodeFacebookPlace < ActiveInteraction::Base
  hash :place do
    string :name, default: nil
    hash :location, default: {} do
      string :city, default: nil
      string :country, default: nil
    end
  end

  def execute
    Rails.logger.debug "Geocoding facebook place: #{place}"
    has_location? ? geocode_by_location : geocode_by_name
  end

  private

  def has_location?
    place['location'].present? && \
    place['location']['city'].present? && \
    place['location']['country'].present?
  end

  def geocode_by_name
    Rails.logger.debug 'Geocoding by place name'

    Nominatim
      .search(place['name'])
      .limit(1)
      .address_details(true)
      .name_details(true)
      .first
  end

  def geocode_by_location
    Rails.logger.debug 'Geocoding by location'

    Nominatim
      .search
      .city(place['location']['city'])
      .country(place['location']['country'])
      .limit(1)
      .address_details(true)
      .name_details(true)
      .first
  end
end
