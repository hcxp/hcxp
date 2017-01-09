class Post < ApplicationRecord
  include RailsSettings::Extend

  belongs_to :user
  belongs_to :team
  has_many :post_bands, dependent: :destroy
  has_many :bands, through: :post_bands

  mount_uploader :thumbnail, PostThumbUploader

  validates :url, presence: true, uniqueness: true

  after_commit :scrap_url, on: :create, if: proc { |p| p.url.present? }

  scope :newest_first, -> { order(created_at: :desc) }

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
end
