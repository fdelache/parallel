require "factorial"
require "strategies/threads"

class ParallelWithThreads
  def self.compute(numbers)
    numbers.parallel(strategy: Strategies::Threads.new).map { |n| Factorial.compute(n) }.reduce(&:+)
  end
end
