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
    format(@base_url, product.item_id)
  end

  def get_parsed_response(response)
    get_parsed_response_string(response)
  end

end

