require_relative "../markets/api/yad2_market"
require_relative "../markets/models/product"
require "test/unit"

class TestYad2Market < Test::Unit::TestCase

  def setup
    @yad2_market = Yad2Market.new
    @product = Product.new(category='subaru')
  end

  def test_get_product_description
    product_description = @yad2_market.get_product_description @product
    puts product_description
  end


end