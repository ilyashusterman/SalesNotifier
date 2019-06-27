require_relative "../markets/api/amazon_market"
require_relative "../markets/models/product"
require "test/unit"

class TestEbayMarket < Test::Unit::TestCase

  def setup
    @amazon_market = AmazonMarket.new
    @product = Product.new(item_id='B01LP3P834')
  end

  def test_get_product_description
    product_description = @amazon_market.get_product_description @product
    assert_equal(2, product_description.length)
  end

  def test_get_product_description_that_does_not_exist
    product = Product.new(item_id=111111111111)
    product_description = @amazon_market.get_product_description product
    assert_equal(1, product_description.length)
  end


end