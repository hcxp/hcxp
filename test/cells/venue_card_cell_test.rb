require 'test_helper'

class VenueCardCellTest < Cell::TestCase
  test "show" do
    html = cell("venue_card").(:show)
    assert html.match /<p>/
  end


end
