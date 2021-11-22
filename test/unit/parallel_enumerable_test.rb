require "test_helper"
require "parallel_enumerable"

class ParallelEnumerableTest < Minitest::Test
  def test_map
    original_collection = 1.step.take(10)

    expected_result = original_collection.map { |n| n + 1 }
    assert_equal expected_result.to_a, ParallelEnumerable.new(original_collection).map { |n| n + 1 }.to_a
  end

  def test_reduce
    original_collection = 1.step.take(10)

    expected_result = original_collection.reduce(&:+)
    assert_equal expected_result, ParallelEnumerable.new(original_collection).reduce(&:+)
  end
end
