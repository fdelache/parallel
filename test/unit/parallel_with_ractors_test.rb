require "test_helper"
require "parallel_with_ractors"

class ParallelWithRactorsTest < Minitest::Test
  def test_result
    assert_equal 3628803, ParallelWithRactors.compute([1, 2, 10])
  end
end
