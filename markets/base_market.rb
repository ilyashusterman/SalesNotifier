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

  def get_product_description(product)
    raise NotImplementedError
  end

  def http_get(domain, headers=nil)
    Net::HTTP.get URI(domain) if headers != {}
    if headers == nil
      Net::HTTP.get URI(domain)
    else
      get_https_with_headers(domain, headers)
    end
  end

  def get_https_with_headers(domain, headers)
    uri = URI(domain)
    request = Net::HTTP::Get.new(uri)
    headers.each do |key, value|
      request[key] = value
    end
    use_ssl = domain.include? "https"
    Net::HTTP.start(uri.host, uri.port, :use_ssl => use_ssl) {|http|
      response = http.request request
      response.body
    }
  end

  def get_parsed_response_string(response)
    JSON.parse(response)
  end

end

