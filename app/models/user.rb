class User < ApplicationRecord
  has_many :events
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
  has_many :team_users
  has_many :teams, through: :team_users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :username, uniqueness: true, presence: true

  def owned_events
    events.where(ownership_type: 'user')
  end
end
