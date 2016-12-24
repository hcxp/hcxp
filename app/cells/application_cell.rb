class ApplicationCell < Cell::ViewModel
  include ActionView::Helpers::TranslationHelper
  include Cell::Translation
  include ActiveLinkTo
  include ActionView::Context
  include ActionView::Helpers::FormHelper
  include ::Rails.application.routes.url_helpers

  def html_safe?
    true
  end
end