require "factorial"

[56132, 43212, 15934].map { |n| Factorial.compute(n) }.reduce(&:+)
