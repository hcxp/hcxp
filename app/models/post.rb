class Post < ApplicationRecord
  include RailsSettings::Extend

  belongs_to :user
  belongs_to :team
  has_many :post_bands, dependent: :destroy
  has_many :bands, through: :post_bands

  mount_uploader :thumbnail, PostThumbUploader

  validates :url, presence: true, uniqueness: true
  validate :assign_to_team_policy, if: proc { |e| e.team_id.present? }

  after_commit :scrap_url, on: :create, if: proc { |p| p.url.present? }

  scope :newest_first, -> { order(created_at: :desc) }

  attr_accessor :actor

  def link?
    url.present?
  end

  def text?
    !link?
  end

  private

  def scrap_url
    ScrapPostUrlWorker.perform_async(id)
  end

  def assign_to_team_policy
    Team.find(team_id)
    return true if Pundit.policy(actor, self).assign?

    errors.add(:base, "You're not authorized to assign posts to given team")
  end
end
