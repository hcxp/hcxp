require 'test_helper'

class BlankslateCellTest < Cell::TestCase
  test "show" do
    html = cell("blankslate").(:show)
    assert html.match /<p>/
  end


end
