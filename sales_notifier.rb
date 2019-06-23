require_relative "markets/amazon_market"
require_relative "markets/ebay_market"

class SalesNotifier

  attr_accessor :market_providers

  def initialize(*args)
    @market_providers = []
  end

  def setup_markets
    @market_providers = [EbayMarket.new, AmazonMarket.new]
    return @market_providers
  end


end
