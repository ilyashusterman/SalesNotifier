require_relative 'markets/amazon_market'
require_relative 'markets/ebay_market'

class SalesNotifier

  attr_accessor :market_providers

  def initialize(products = [])
    @market_providers = setup_markets
    @products = products
  end

  def setup_markets
    [EbayMarket.new, AmazonMarket.new]
  end

  def get_sales
    sales = []
    @market_providers.each do |market|
      market_products = get_market_products(market)
      sales.append market.map_product_descriptions(market_products)
    end
    sales
  end

  def get_market_products(market)
    @products.select {|product| product.market == market.name}
  end


end
