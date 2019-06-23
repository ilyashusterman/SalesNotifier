require 'json'
require 'concurrent'
require_relative '../markets/base_market'


class EbayMarket < BaseMarket

  def initialize
    super 'Ebay'
    @base_url = 'https://www.ebay.com/lit/v1/item?pbv=1&item=%s'
  end

  def get_product_description(product)
    product_url = get_product_url(product)
    response = http_get(product_url)
    get_parsed_response response
  end

  def get_product_url(product)
    format(@base_url, product[:item_id])
  end

  def get_parsed_response(response)
    JSON.parse(response)
  end

  def map_product_descriptions(products)
    pool = Concurrent::ThreadPoolExecutor.new(
      min_threads: 3,
      max_threads: 10,
      max_queue: 100
    )
    descriptions = []
    products.each do |product|
      pool.post do
        description = get_product_description product
        descriptions.append description
      end
    end
    pool.shutdown
    pool.wait_for_termination
    descriptions
  end
end

