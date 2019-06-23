require_relative '../markets/base_market'


class AmazonMarket < BaseMarket
  def initialize
    super 'Amazon'
    @base_url = 'https://www.ebay.com/lit/v1/item?pbv=1&item=%s'
  end

end