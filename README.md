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
