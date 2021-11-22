require "test_helper"
require "factorial"

class FactorialTest < Minitest::Test
  def test_compute_1
    assert_equal 1, Factorial.compute(1)
  end

  def test_compute_2
    assert_equal 2, Factorial.compute(2)
  end

  def test_compute_10
    assert_equal 3628800, Factorial.compute(10)
  end
end
