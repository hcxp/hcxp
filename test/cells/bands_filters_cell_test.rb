require 'test_helper'

class BandsFiltersCellTest < Cell::TestCase
  test "show" do
    html = cell("bands_filters").(:show)
    assert html.match /<p>/
  end


end
