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

  def unparallel
    @original_collection
  end

  def each(&block)
    @original_collection.each(&block)
  end

  def map(&block)
    ractors = []
    shareable_block = Ractor.make_shareable(block.curry)
    slices.each do |sub_elements|
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

  def slices
    unless defined?(@slices)
      slice_size = @original_collection.count / ractor_count
      @slices = @original_collection.each_slice(slice_size)
    end

    @slices
  end
end
