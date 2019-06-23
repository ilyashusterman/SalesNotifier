# frozen_string_literal: true

require 'concurrent'

MIN_THREADS = 3
MAX_THREADS = 10
MAX_QUEUE = 100

module BaseConcurrent
  class << self
    # @list_of_attributes List[args_for_method]
    # @method_func should be the method name
    # Example : method(:get_product_description)
    def map(list_of_attributes, method_func)
      pool = Concurrent::ThreadPoolExecutor.new(
        min_threads: MIN_THREADS,
        max_threads: MAX_THREADS,
        max_queue: MAX_QUEUE
      )
      descriptions = []
      list_of_attributes.each do |attribute|
        pool.post do
          description = method_func.call(attribute)
          descriptions.append description
        end
      end
      pool.shutdown
      pool.wait_for_termination
      descriptions
    end

  end

end
