class Band < ApplicationRecord
  include Geokit::Geocoders
  include PgSearch
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :bandables, dependent: :destroy
  has_many :events, through: :bandables, source: :bandable, source_type: 'Event'
  has_many :post_bands
  has_many :posts, through: :post_bands

  before_validation :geocode, if: :location_changed?

  pg_search_scope :search, against: [:name, :location], using: { tsearch: { prefix: true } }

  validates :name, presence: true
  validates :location, presence: true

  def search_label
    "#{name} (#{country_code})"
  end

  def post_for_player
    posts.newest_first.with_settings_for('bandcamp_album_id').first
  end

  private # --------------------------------------------------------------------

  def geocode
    loc = MultiGeocoder.geocode(location)

    if loc.success
      self.lat           = loc.lat
      self.lng           = loc.lng
      self.location      = loc.full_address
      self.city          = loc.city
      self.country_code  = loc.country_code
    end
  end
end
