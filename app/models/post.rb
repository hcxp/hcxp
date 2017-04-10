class Post < ApplicationRecord
  include PgSearch
  include RailsSettings::Extend

  TYPES = %w(text link).freeze
  DEFAULT_TYPE = 'link'

  # Make it able to use `type` column
  self.inheritance_column = 'inheritance_type'

  attr_accessor :actor

  belongs_to :user
  belongs_to :team
  belongs_to :venue
  has_many :post_bands, dependent: :destroy
  has_many :bands, through: :post_bands

  mount_uploader :thumbnail, PostThumbUploader

  validates :url, presence: true, uniqueness: true, if: :link?
  validates :title, presence: true, if: :text?
  validates :body, presence: true, if: :text?
  validates :type, presence: true, inclusion: { in: TYPES }
  validate :assign_to_team_policy, if: proc { |p| p.team_id.present? }

  before_validation :set_defaults
  after_commit :scrap_url, on: :create, if: proc { |p| p.url.present? }
  after_commit :scrap_bands_photos, on: :create, if: proc { |p| p.url.present? }

  scope :newest_first, -> { order(created_at: :desc) }

  # pg_search_scope :search, against: [:title], using: { tsearch: { prefix: true } }, associated_against: {
  #   bands: [:name],
  #   venue: [:name, :address]
  # }

  pg_search_scope :search, against: [:title]

  attr_accessor :actor

  def link?
    type == 'link'
  end

  def text?
    type == 'text'
  end

  def bandcamp?
    URI(url).host[/bandcamp.com\z/] != nil
  end

  def scrap_bands_photos
    return true unless bandcamp?

    bands_to_scrap = bands.where(photo: nil)
    logger.info "Creating photo-fetch job for #{bands_to_scrap.size} bands"

    bands_to_scrap.each do |band|
      ScrapBandcampPhotoWorker.perform_async(band.id, url)
    end

    true
  end

  private # --------------------------------------------------------------------

  def scrap_url
    ScrapPostUrlWorker.perform_async(id)
  end

  def assign_to_team_policy
    Team.find(team_id)
    return true if Pundit.policy(actor, self).assign?

    errors.add(:base, "You're not authorized to assign posts to given team")
  end

  def set_defaults
    self.type = DEFAULT_TYPE
  end
end
