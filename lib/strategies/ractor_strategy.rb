# frozen_string_literal: true
require 'etc'

module Strategies
  class RactorStrategy
    def map(original_collection, &block)
      ractor_count = [processor_count, original_collection.count].min
      slice_size = original_collection.count / ractor_count

      ractors = []
      shareable_block = Ractor.make_shareable(block.curry)
      original_collection.each_slice(slice_size) do |sub_elements|
        ractors << Ractor.new(sub_elements, shareable_block) do |elements, block|
          elements.map(&block)
        end
      end

      ractors.flat_map(&:take)
    end

    private
  
    def processor_count
      Etc.nprocessors
    end
  
  end
end
