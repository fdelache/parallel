require 'test_helper'
require 'parallel_with_parallel_enumerable'

class ParallelWithParallelEnumerableTest < Minitest::Test
  def test_result
    assert_equal 3628803, ParallelWithParallelEnumerable.compute([1, 2, 10])
  end
end
