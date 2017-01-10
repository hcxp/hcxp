class Team < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :posts
  has_many :events
  has_many :team_users
  has_many :users, through: :team_users

  mount_uploader :avatar, TeamAvatarUploader
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
end
