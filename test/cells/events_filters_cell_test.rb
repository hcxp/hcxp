require 'test_helper'

class EventsFiltersCellTest < Cell::TestCase
  test "show" do
    html = cell("events_filters").(:show)
    assert html.match /<p>/
  end


end
