require 'net/http'
require 'uri'
require 'cgi'

class BaseMarket
  def initialize(name)
    @name = name
    print "#{@name} Market initialized"
  end

  def http_get(domain)
    Net::HTTP.get URI(domain)
  end

  def get_product_details(product_name)

  end

end

