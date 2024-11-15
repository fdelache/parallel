# frozen_string_literal: true
require 'etc'

module Strategies
  class Threads
    def map(original_collection, &block)
      thread_count = [processor_count, original_collection.count].min
      slice_size = original_collection.count / thread_count

      threads = []
      original_collection.each_slice(slice_size) do |sub_elements|
        threads << Thread.new do
          sub_elements.map(&block)
        end
      end

      threads.flat_map(&:value)
    end

    private
  
    def processor_count
      Etc.nprocessors
    end
  end
end