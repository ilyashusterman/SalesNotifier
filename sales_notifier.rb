require_relative 'markets/api/amazon_market'
require_relative 'markets/api/ebay_market'

class SalesNotifier

  attr_accessor :market_providers

  def initialize(products = [])
    @market_providers = setup_markets
    @products = products
  end

  def setup_markets
    [EbayMarket.new, AmazonMarket.new]
  end

  # @return List[Hash] for product descriptions
  def get_products_sales
    get_products_descriptions
    # TODO: implement logic for
    # 3. notify if their price reduced
    # 4. notify for good reviews
  end

  def get_products_descriptions
    products_descriptions = []
    @market_providers.each do |market|
      market_products = get_market_products(market)
      products_descriptions.append market.map_product_descriptions(market_products)
    end
    products_descriptions
  end

  def get_market_products(market)
    @products.select {|product| product.market_name == market.name}
  end

end
