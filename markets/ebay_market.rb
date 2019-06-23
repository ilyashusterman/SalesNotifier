require 'json'

require_relative '../markets/base_market'

class EbayMarket < BaseMarket

  def initialize
    super 'Ebay'
    @base_url = 'https://www.ebay.com/lit/v1/item?pbv=1&item=%s&cb=%s'
  end

  def get_product_details(product)
    product_url = get_product_url(product)
    response = http_get(product_url)
    parsed = get_parsed_response(response, product[:query_name])
    JSON.parse(parsed)
  end

  def get_product_url(product)
    format(@base_url, product[:item_id], product[:query_name])
  end

  # @param [Response] response
  # @param [String] query_name parsed from ebay
  def get_parsed_response(response, query_name)
    response.split(query_name)[1][3..-3]
  end
end

