require 'test_helper'

class FlashMessagesCellTest < Cell::TestCase
  test "show" do
    html = cell("flash_messages").(:show)
    assert html.match /<p>/
  end


end
