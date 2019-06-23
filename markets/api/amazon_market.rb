require_relative '../base_market'

class AmazonMarket < BaseMarket
  def initialize
    super 'Amazon'
    @base_url = 'https://www.amazon.com/item=%s'
  end

end