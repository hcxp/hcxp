require 'test_helper'

class PostsFiltersCellTest < Cell::TestCase
  test "show" do
    html = cell("posts_filters").(:show)
    assert html.match /<p>/
  end


end
