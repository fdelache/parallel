require "test_helper"
require "sequential"

class SequentialTest < Minitest::Test
  def test_result
    assert_equal 3628803, Sequential.compute([1, 2, 10])
  end
end
