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

  def update?
    @post.user == @user
  end

  def edit?
    @post.user == @user
  end
end
