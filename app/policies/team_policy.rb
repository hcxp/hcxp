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

  def edit_users?
    update?
  end

  def invite_user?
    edit_users?
  end

  def remove_user?
    edit_users?
  end
end
