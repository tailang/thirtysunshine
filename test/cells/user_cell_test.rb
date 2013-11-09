require 'test_helper'

class UserCellTest < Cell::TestCase
  test "douban" do
    invoke :douban
    assert_select "p"
  end
  

end
