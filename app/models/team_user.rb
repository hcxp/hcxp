class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  attr_accessor :username

  validate :user_is_not_owner
  validates :user, presence: true, uniqueness: { scope: :team }
  validates :team, presence: true

  private # --------------------------------------------------------------------

  def user_is_not_owner
    if user == team.user
      errors.add(:user, 'has already been taken')
    end
  end
end
