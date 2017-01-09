class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user  = user
    @event = event
  end

  def assign?
    @team.users.include? @user
  end

  def new?
    @user.present?
  end

  def update?
    @event.user == @user
  end

  def edit?
    @event.user == @user
  end
end
