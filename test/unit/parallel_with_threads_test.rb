require "test_helper"
require "parallel_with_threads"

class ParallelWithThreadsTest < Minitest::Test
  def test_result
    assert_equal 3628803, ParallelWithThreads.compute([1, 2, 10])
  end
end
