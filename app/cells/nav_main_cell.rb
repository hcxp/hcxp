class NavMainCell < ApplicationCell
  include Devise::Controllers::Helpers

  def show
    render (options[:team]) ? 'show_team' : 'show'
  end

  private

  def team
    options[:team] ? options[:team].decorate : nil
  end

  def user_decor
    current_user.decorate
  end

  def navbar_class
    options[:css_class]
  end

end
