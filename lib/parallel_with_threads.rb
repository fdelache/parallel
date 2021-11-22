require "factorial"

class ParallelWithThreads
  def self.compute(numbers)
    numbers.map do |n|
      Thread.new do
        Factorial.compute(n)
      end
    end.map(&:value).reduce(&:+)
  end
end
