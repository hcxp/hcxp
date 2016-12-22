require 'test_helper'

class LanguagePickerCellTest < Cell::TestCase
  test "show" do
    html = cell("language_picker").(:show)
    assert html.match /<p>/
  end


end
