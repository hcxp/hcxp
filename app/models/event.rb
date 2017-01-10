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
  validate :assign_to_team_policy, if: Proc.new { |e| e.team_id.present? }

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

  def assign_to_team_policy
    Team.find(self.team_id)
    return true if Pundit.policy(actor, self).assign?

    errors.add(:base, "You're not authorized to assign events to given team")
  end
end
