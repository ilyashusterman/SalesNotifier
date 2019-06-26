require 'nokogiri'

require_relative '../base_market'


class AmazonMarket < BaseMarket
  XPATH_AVAILABILITY = '//div[@id ="availability"]//text()'
  XPATH_PRICE = '//*[@id="a-autoid-7-announce"]//text()'
  def initialize
    super 'Amazon'
    @base_url = 'https://www.amazon.com/dp/%s'
    @headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36",
    "Origin": "https://www.amazon.com",
    "DNT": 1
    }
  end

    def get_product_description(product)
    product_url = get_product_url(product)
    # @headers['Referer'] = product_url
    response_body = http_get(product_url, @headers)
    get_parsed_response response_body
  end

  def get_product_url(product)
    format(@base_url, product.item_id)
  end

  def get_parsed_response(response)
    html = Nokogiri::HTML(response)
    description = {}
    html.xpath(XPATH_AVAILABILITY).each {|link|
      # availability = link.content.gsub(' ','').gsub('\n','')
      availability = link.content.lstrip
      puts availability
      description['availability'] = availability
    }
    html.xpath(XPATH_PRICE).each {|link|
      puts link.content
      description['price'] = link.content.lstrip
    }
    description
  end


end