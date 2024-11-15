# frozen_string_literal: true
require 'forwardable'
require 'strategies/ractors'

module Enumerable
  def parallel(strategy: Strategies::Ractors.new)
    ParallelEnumerable.new(self, strategy:)
  end
end

class ParallelEnumerable
  include Enumerable

  # @param original_collection: The Enumerable to parallelize.
  def initialize(original_collection, strategy: Strategies::Ractors.new)
    @original_collection = original_collection
    @strategy = strategy
  end

  def each(&block)
    @original_collection.each(&block)
  end

  def map(&block)
    ParallelEnumerable.new(strategy.map(original_collection, &block), strategy:)
  end

  private

  attr_reader :strategy, :original_collection
end
