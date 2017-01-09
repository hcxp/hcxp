class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def new?
    @user.present?
  end

  def update?
    @team.user == @user
  end

  def edit?
    update?
  end
end
