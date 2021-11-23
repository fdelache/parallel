# frozen_string_literal: true

# Non-recursive implementation of Factorial computation
class Factorial
  def self.compute(n)
    return n if n <= 2

    result = n
    current = n
    until (current = current - 1) < 1
      result *= current
    end
    result
  end
end
