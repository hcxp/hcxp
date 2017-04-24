class Event < ApplicationRecord
  include PgSearch

  is_impressionable counter_cache: true

  OWNERSHIP_TYPES = %w(user unassigned).freeze
  STATUSES = %w(draft published).freeze

  mount_uploader :poster, ::EventPosterUploader

  belongs_to :user
  has_many :bandables, as: :bandable, dependent: :destroy
  has_many :bands, through: :bandables
  belongs_to :venue
  belongs_to :team

  attr_accessor :actor

  validates :status, inclusion: { in: STATUSES }

  with_options if: :is_published? do |published|
    published.validates :link, format: URI::regexp(%w(http https)), if: proc { |e| e.link.present? }
    published.validate :assign_to_team_policy, if: proc { |e| e.team_id.present? }
    published.validate :name_or_bands_validator
    published.validates :beginning_at, presence: true
    published.validates :ownership_type, presence: true
    published.validates :ownership_type, allow_blank: true, inclusion: { in: OWNERSHIP_TYPES }
    published.validates :venue_id, presence: true
  end

  scope :upcoming,    -> { where('beginning_at >= ?', Time.zone.now.beginning_of_day) }
  scope :past,        -> { where('beginning_at < ?', Time.zone.now.beginning_of_day) }
  scope :with_poster, -> { where.not(poster: nil) }
  scope :published,   -> { where(status: :published) }

  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }, associated_against: {
    bands: [:name],
    venue: [:name, :address]
  }

  accepts_nested_attributes_for :bandables, allow_destroy: true

  before_validation :set_defaults
  # after_commit :notify, on: :create

  private # --------------------------------------------------------------------

  def is_published?
    status.to_sym == :published
  end

  def set_defaults
    self.status ||= :draft
  end

  def has_bands?
    bands.any?
  end

  def assign_to_team_policy
    Team.find(team_id)
    return true if Pundit.policy(actor, self).assign?

    errors.add(:base, "You're not authorized to assign events to given team")
  end

  def name_or_bands_validator
    if !name.present? && !has_bands?
      errors.add(:base, 'You must either assign bands or set a name for this event')
    else
      return true
    end
  end

  def notify
    decor = decorate
    post = {
      attachments: [{
        fallback:   'New event created',
        pretext:    'New event created',
        thumb_url:  decor.poster_url(100, 100),
        title:      decor.name_or_bands,
        title_link: decor.public_html_url,
        ts:         beginning_at.to_i,
        fields: [
          { title: 'Bands', value: bands.map(&:name).join(', ') },
          { title: 'User', value: user.username },
        ],
      }]
    }
    SlackNotificationWorker.perform_async(post)
  end
end
