require 'test_helper'

class PostCardCellTest < Cell::TestCase
  test "show" do
    html = cell("post_card").(:show)
    assert html.match /<p>/
  end


end
