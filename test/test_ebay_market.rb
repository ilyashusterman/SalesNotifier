
# File:  tc_simple_number.rb

require_relative "../markets/ebay_market"
require "test/unit"

class TestSalesNotifier < Test::Unit::TestCase

  def setup
    @ebay = EbayMarket.new
  end

  def test_setup_markets
    product = {
        'item_id':392315084973,
        'query_name': 'jQuery1708731352142529449_1561243321737'
    }
    details = @ebay.get_product_details product
    assert_equal(1, details.length)
  end

end