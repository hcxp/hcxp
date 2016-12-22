class ApplicationCell < Cell::ViewModel
  include ActionView::Helpers::TranslationHelper
  include Cell::Translation
  include ActiveLinkTo

  def output_buffer=(*)
  end
end