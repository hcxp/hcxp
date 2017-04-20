class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user  = user
    @post = post
  end

  def assign?
    team = post.team
    Pundit.policy(@post.actor, team).assign_post?
  end

  def new?
    @user.present?
  end

  def edit?
    @post.user == @user || @user.is_admin?
  end

  def update?
    edit?
  end

  def destroy?
    (
      @post.user == @user && @post.created_at > 2.weeks.ago
    ) || @user.is_admin?
  end
end
