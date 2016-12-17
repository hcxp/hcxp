class Band < ApplicationRecord
  include Geokit::Geocoders
  include PgSearch

  belongs_to :user
  has_many :event_bands
  has_many :events, through: :event_bands

  before_validation :geocode, if: :location_changed?

  pg_search_scope :search, against: [:name, :location], using: { tsearch: { prefix: true } }

  def search_label
    "#{name} (#{country_code})"
  end

  private # --------------------------------------------------------------------

  def geocode
    loc = MultiGeocoder.geocode(location)

    if loc.success
      self.lat           = loc.lat
      self.lng           = loc.lng
      self.location       = loc.full_address
      self.city          = loc.city
      self.country_code  = loc.country_code
    end
  end
end
