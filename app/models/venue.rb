class Venue < ApplicationRecord
  include Geokit::Geocoders
  include PgSearch
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :events

  validates :address, presence: true

  before_validation :geocode, if: :address_changed?

  pg_search_scope :search, against: [:name, :address], using: { tsearch: { prefix: true } }

  def search_label
    "#{name} (#{city}, #{country_code})"
  end

  private # --------------------------------------------------------------------

  def geocode
    return true if ENV['DISABLE_GEOCODING']

    loc = MultiGeocoder.geocode(address)

    if loc.success
      self.lat           = loc.lat
      self.lng           = loc.lng
      self.address       = loc.full_address
      self.city          = loc.city
      self.country_code  = loc.country_code
      self.street_name   = loc.street_name
      self.street_number = loc.street_number

      errors.add(:base, 'We were not able to get city from given address. Are
        you sure you formatted it correctly?') unless self.city.present?
      errors.add(:base, 'We were not able to get country from given address. Are
        you sure you formatted it correctly?') unless self.country_code.present?

    elsif address.present?
      errors.add(:base, 'We were not able to find given address')
    end
  end
end
