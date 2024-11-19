# frozen_string_literal: true
require 'forwardable'
require 'etc'

module Enumerable
  def parallel
    ParallelEnumerable.from_enumerable(self)
  end
end

class ParallelEnumerable
  include Enumerable

  class << self
    def from_enumerable(enumerable)
      new(enumerable:)
    end

    def from_slices(slices)
      new(slices:)
    end
  end
  
  def unparallel
    enumerable
  end

  def each(&block)
    enumerable.each(&block)
  end

  def map(&block)
    ractors = []
    shareable_block = Ractor.make_shareable(block.curry)
    slices.each do |sub_elements|
      ractors << Ractor.new(sub_elements, shareable_block) do |elements, block|
        elements.map(&block)
      end
    end

    ParallelEnumerable.from_slices(ractors.map(&:take))
  end

  private

  def initialize(enumerable: nil, slices: nil)
    # We only accept one or the other, but not both.
    raise unless enumerable.nil? ^ slices.nil?

    @enumerable = enumerable
    @slices = slices
  end

  def ractor_count
    [processor_count, enumerable.count].min
  end

  def processor_count
    Etc.nprocessors
  end

  def enumerable
    @enumerable ||= slices.flatten
  end

  def slices
    if @slices.nil?
      slice_size = enumerable.count / ractor_count
      @slices = enumerable.each_slice(slice_size)
    end

    @slices
  end
end
