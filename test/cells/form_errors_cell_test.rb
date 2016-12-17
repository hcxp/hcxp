require 'test_helper'

class FormErrorsCellTest < Cell::TestCase
  test "show" do
    html = cell("form_errors").(:show)
    assert html.match /<p>/
  end


end
