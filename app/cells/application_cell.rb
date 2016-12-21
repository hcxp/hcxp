class ApplicationCell < Cell::ViewModel
  include ActionView::Helpers::TranslationHelper
  include Cell::Translation
  include ActiveLinkTo
  include ActionView::Context
end