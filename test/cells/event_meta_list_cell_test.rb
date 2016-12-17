require 'test_helper'

class EventMetaListCellTest < Cell::TestCase
  test "show" do
    html = cell("event_meta_list").(:show)
    assert html.match /<p>/
  end


end
