require 'test_helper'

class VenuesFiltersCellTest < Cell::TestCase
  test "show" do
    html = cell("venues_filters").(:show)
    assert html.match /<p>/
  end


end
