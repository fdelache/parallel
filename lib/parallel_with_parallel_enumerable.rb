require 'factorial'
require 'parallel_enumerable'

class ParallelWithParallelEnumerable
  def self.compute(numbers)
    numbers.parallel.map { |n| Factorial.compute(n) }.reduce(&:+)
  end
end
