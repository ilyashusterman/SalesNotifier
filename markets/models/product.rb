# frozen_string_literal: true

BaseProduct = Struct.new(:item_id, :market_name)

class Product < BaseProduct
  def initialize(item_id, market_name = 'no_market_initialized')
    super
  end
end