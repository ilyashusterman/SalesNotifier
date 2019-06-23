require 'net/http'
require 'uri'
require 'json'

require_relative '../markets/base_concurrent'

class BaseMarket
  attr_accessor :name
  def initialize(name)
    @name = name
    puts "#{@name} Market initialized"
  end

  def map_product_descriptions(products)
    BaseConcurrent.map(products, method(:get_product_description))
  end

  def get_product_description(product_name)
    raise NotImplementedError
  end

  def http_get(domain)
    Net::HTTP.get URI(domain)
  end

  def get_parsed_response_string(response)
    JSON.parse(response)
  end


end

