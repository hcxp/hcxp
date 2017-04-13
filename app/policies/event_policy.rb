class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user  = user || User.new
    @event = event
  end

  def assign?
    team = event.team
    Pundit.policy(@event.actor, team).assign_event?
  end

  def new?
    @user.present?
  end

  def edit?
    @event.user == @user || @user.is_admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
