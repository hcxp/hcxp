class Event < ApplicationRecord
  include PgSearch

  OWNERSHIP_TYPES = %w(user unassigned).freeze

  mount_uploader :poster, ::EventPosterUploader

  belongs_to :user
  has_many :bandables, as: :bandable, dependent: :destroy
  has_many :bands, through: :bandables
  belongs_to :venue
  belongs_to :team

  attr_accessor :actor

  validates :name, presence: true, unless: :has_bands?
  validates :beginning_at, presence: true
  validates :ownership_type, presence: true
  validates :ownership_type, allow_blank: true, inclusion: { in: OWNERSHIP_TYPES }
  validates :link, format: URI::regexp(%w(http https)), if: proc { |e| e.link.present? }
  validate :assign_to_team_policy, if: proc { |e| e.team_id.present? }

  scope :upcoming, -> { where('beginning_at >= ?', Time.zone.now.beginning_of_day) }
  scope :past,     -> { where('beginning_at < ?', Time.zone.now.beginning_of_day) }

  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }, associated_against: {
    bands: [:name],
    venue: [:name, :address]
  }

  after_commit :notify, on: :create

  private # --------------------------------------------------------------------

  def has_bands?
    bands.any?
  end

  def assign_to_team_policy
    Team.find(team_id)
    return true if Pundit.policy(actor, self).assign?

    errors.add(:base, "You're not authorized to assign events to given team")
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
