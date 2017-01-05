require 'test_helper'

class PostPlayerCellTest < Cell::TestCase
  test "show" do
    html = cell("post_player").(:show)
    assert html.match /<p>/
  end


end
