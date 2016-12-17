require 'test_helper'

class NavMainCellTest < Cell::TestCase
  test "show" do
    html = cell("nav_main").(:show)
    assert html.match /<p>/
  end


end
