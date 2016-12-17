class NavMainCell < Cell::ViewModel
  include ActiveLinkTo
  include Devise::Controllers::Helpers

  def show
    render
  end

  private

  def navbar_class
    options[:css_class]
  end

end
