class User < ApplicationRecord
  has_many :events
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :owned_teams, class_name: 'Team'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :username, presence: true, allow_blank: true
  validates :username, allow_blank: true, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/ }, allow_blank: true
  validates :username, length: { minimum: 2, maximum: 15 }

  def owned_events
    events.where(ownership_type: 'user')
  end
end
