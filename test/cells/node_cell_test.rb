require 'test_helper'

class NodeCellTest < Cell::TestCase
  test "node_infos" do
    invoke :node_infos
    assert_select "p"
  end
  

end
