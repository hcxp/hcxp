class BandPolicy < ApplicationPolicy
  attr_reader :user, :band

  def initialize(user, band)
    @user = user || User.new
    @band = band
  end

  def edit?
    @user.is_admin?
  end

  def update?
    edit?
  end

  def refetch_photo?
    edit?
  end
end
