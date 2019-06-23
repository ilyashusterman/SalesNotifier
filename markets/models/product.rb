# frozen_string_literal: true

BaseProduct = Struct.new(:item_id, :market)

class Product < BaseProduct
  def initialize(item_id, market = 'no_market_initialized')
    super
  end
end