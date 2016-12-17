class Event < ApplicationRecord
  include PgSearch

  OWNERSHIP_TYPES = %w(user unassigned).freeze

  mount_uploader :poster, ::EventPosterUploader

  belongs_to :user
  has_many :event_bands
  has_many :bands, through: :event_bands
  belongs_to :venue

  validates :name, presence: true, unless: :has_bands?
  validates :beginning_at, presence: true
  validates :ownership_type, presence: true
  validates :ownership_type, allow_blank: true, inclusion: { in: OWNERSHIP_TYPES }

  scope :upcoming, -> { where('beginning_at >= ?', Time.zone.now.beginning_of_day) }
  scope :past,     -> { where('beginning_at < ?', Time.zone.now.beginning_of_day) }

  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }, associated_against: {
    bands: [:name],
    venue: [:name, :address]
  }

  private

  def has_bands?
    bands.any?
  end
end
