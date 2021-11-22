# frozen_string_literal: true
require 'forwardable'
require 'etc'

module Enumerable
  def parallel
    ParallelEnumerable.new(self)
  end
end

class ParallelEnumerable
  include Enumerable

  # @param original_collection: The Enumerable to parallelize.
  def initialize(original_collection)
    @original_collection = original_collection
  end

  def each(&block)
    @original_collection.each(&block)
  end

  def map(&block)
    slice_size = @original_collection.count / ractor_count

    ractors = []
    shareable_block = Ractor.make_shareable(block)
    @original_collection.each_slice(slice_size) do |sub_elements|
      ractors << Ractor.new(sub_elements, shareable_block) do |elements, block|
        elements.map(&block)
      end
    end

    ParallelEnumerable.new(ractors.flat_map(&:take))
  end

  private

  def ractor_count
    [processor_count, @original_collection.count].min
  end

  def processor_count
    Etc.nprocessors
  end
end
