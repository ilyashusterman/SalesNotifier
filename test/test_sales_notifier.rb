# File:  tc_simple_number.rb

require_relative "../sales_notifier"
require "test/unit"

class TestSalesNotifier < Test::Unit::TestCase

  def setup
    @sales_notifier = SalesNotifier.new
  end

  def test_setup_markets
    @sales_notifier.setup_markets
    assert_equal(2, @sales_notifier.market_providers.length)
  end

end