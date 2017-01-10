class Team < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :events
  has_many :team_users
  has_many :users, through: :team_users

  mount_uploader :avatar, TeamAvatarUploader

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
end
