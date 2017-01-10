require 'test_helper'

class BandsListCellTest < Cell::TestCase
  test "show" do
    html = cell("bands_list").(:show)
    assert html.match /<p>/
  end


end
