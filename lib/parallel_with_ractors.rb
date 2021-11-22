require "factorial"

class ParallelWithRactors
  def self.compute(numbers)
    numbers.map do |n|
      Ractor.new n do |msg|
        Factorial.compute(msg)
      end
    end.map(&:take).reduce(&:+)
  end
end
