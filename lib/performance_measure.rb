require 'benchmark'
require 'sequential'
require 'parallel_with_threads'
require 'parallel_with_ractors'
require 'parallel_with_parallel_enumerable'

NUMBERS = 32340.step.take(10).freeze

Benchmark.bmbm do |x|
  x.report('sequential') { Sequential.compute(NUMBERS) }
  x.report('threads') { ParallelWithThreads.compute(NUMBERS) }
  x.report('ractors') { ParallelWithRactors.compute(NUMBERS) }
  x.report('parallel_enumerable') { ParallelWithParallelEnumerable.compute(NUMBERS) }
end
