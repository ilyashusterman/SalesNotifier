require 'nokogiri'

require_relative '../base_market'


class AmazonMarket < BaseMarket
  XPATH_AVAILABILITY = '//div[@id ="availability"]//text()'
  XPATH_PRICE = '//*[@id="priceblock_ourprice"]//text()'
  PAGE_NOT_FOUND = 'title'
  AMAZON_ITEM_HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36",
    "Origin": "https://www.amazon.com",
    "DNT": 1
  }

  def initialize
    super 'Amazon'
    @base_url = 'https://www.amazon.com/dp/%s'
  end

    def get_product_description(product)
    product_url = get_product_url(product)
    response_body = http_get(product_url, AMAZON_ITEM_HEADERS)
    get_parsed_response response_body
  end

  def get_product_url(product)
    format(@base_url, product.item_id)
  end

  def get_parsed_response(response)
    html = Nokogiri::HTML(response)
    build_description(html)
  end

  def build_description(html)
    description = {}
    html.search(PAGE_NOT_FOUND).each do |link|
        description['error'] = link.content.lstrip if link.content.include? 'Page Not Found'
    end
    html.xpath(XPATH_AVAILABILITY).each {|link|
      description['availability'] = link.content.gsub(' ','').gsub('.\n\n\n','').lstrip if link.content.include? 'Stock'
    }
    html.xpath(XPATH_PRICE).each {|link|
      description['price'] = link.content.lstrip
    }
    description
  end


end