require 'test_helper'

class AdCellTest < Cell::TestCase
  test "gongyi1" do
    invoke :gongyi1
    assert_select "p"
  end
  

end
