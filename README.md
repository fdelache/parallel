# Parallel enumeration with Ractors 

An exploration into Ractors.

# Set up

Run `bundle install`

# Using the ParallelEnumerable

Simply require the parallel_enumerable, and call `parallel` on your original enumerable. It will parallelize as much as it can any operations made on that collection.
For now only the `map` operation is parallelized, but more will come.

```ruby
require 'parallel_enumerable'

collection.parallel.map { |n| cpu_intensive_operation(n) }
```

# Testing

Run `rake test` 

# Benchmarking
You can benchmark the different ways to run a CPU intensive operation (factorial), using different strategies:
```
❯ bin/benchmark                                        
Rehearsal -------------------------------------------------------
sequential            3.700499   2.552881   6.253380 (  6.275990)
threads               3.551265   1.740886   5.292151 (  5.332419)
ractors               4.870103   1.153873   6.023976 (  1.774149)
parallel_enumerable   4.864191   1.229560   6.093751 (  1.896910)
--------------------------------------------- total: 23.663258sec

                          user     system      total        real
sequential            3.610238   3.002262   6.612500 (  6.679901)
threads               3.570723   2.033741   5.604464 (  5.643820)
ractors               4.801946   1.140257   5.942203 (  1.749837)
parallel_enumerable   4.816865   1.048911   5.865776 (  1.701564)

```
