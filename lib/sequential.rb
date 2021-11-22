require "factorial"

class Sequential
  def self.compute(numbers)
    numbers.map { |n| Factorial.compute(n) }.reduce(&:+)
  end
end

