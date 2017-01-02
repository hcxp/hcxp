class Post < ApplicationRecord
  belongs_to :user
  has_many :post_bands
  has_many :bands, through: :post_bands

  mount_uploader :thumbnail, PostThumbUploader

  validates :url, presence: true, uniqueness: true

  after_create :scrap_url, if: proc { |p| p.url.present? }

  private

  def scrap_url
    ScrapPostUrlWorker.perform_async(id)
  end
end
