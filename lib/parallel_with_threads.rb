require "factorial"

[56132, 43212, 15934].map do |n|
  Thread.new do
    Factorial.compute(n)
  end
end.map(&:value).reduce(&:+)
