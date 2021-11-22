require "factorial"

[56132, 43212, 15934].map do |n|
  Ractor.new n do |msg|
    Factorial.compute(msg)
  end
end.map(&:take).reduce(&:+)
