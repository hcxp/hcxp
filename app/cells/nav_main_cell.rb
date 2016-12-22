class NavMainCell < ApplicationCell
  include Devise::Controllers::Helpers

  def show
    render
  end

  private

  def user_decor
    current_user.decorate
  end

  def navbar_class
    options[:css_class]
  end

end
