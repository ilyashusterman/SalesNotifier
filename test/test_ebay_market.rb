
# File:  tc_simple_number.rb

require_relative "../markets/api/ebay_market"
require_relative "../markets/models/product"
require "test/unit"

class TestSalesNotifier < Test::Unit::TestCase

  def setup
    @ebay = EbayMarket.new
  end

  def test_get_product_description
    product = Product.new(item_id=392315084973)
    product_description = @ebay.get_product_description product
    assert_equal(1, product_description.length)
  end

  def test_get_product_url
    product = Product.new(item_id=392315084973)
    assert_equal('https://www.ebay.com/lit/v1/item?pbv=1&item=392315084973', @ebay.get_product_url(product))
  end

  def test_get_products_description
    products = [
        Product.new(item_id=392315084973),
        Product.new(item_id=264364448103)
    ]
    products_descriptions = @ebay.map_product_descriptions products
    assert_equal(2, products_descriptions.length)
  end

end