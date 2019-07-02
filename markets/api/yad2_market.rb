require 'nokogiri'

require_relative '../base_market'


class Yad2Market < BaseMarket
  XPATH_ITEM = '//div[@id ="__layout"]/div/main/div[1]/div[4]/div[6]/div[2]'
  # XPATH_PRICE = '//*[@id="priceblock_ourprice"]//text()'
  HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"
  }

  def initialize
    super 'Yad2'
    @base_url = 'https://www.yad2.co.il/vehicles/private-cars?manufacturer=27&model=891&year=2006-2019&price=0-25000&imgOnly=1&priceOnly=1&Order=5'
  end

    def get_product_description(product)
    product_url = get_product_url(product)
    response_body = http_get(product_url, HEADERS)
    get_parsed_response response_body
  end

  def get_product_url(product)
    # format(@base_url, product.item_id)
    @base_url
  end

  def get_parsed_response(response)
    html = Nokogiri::HTML(response)
    build_description(html)
  end

  def build_description(html)
    description = {}
    # html.search(PAGE_NOT_FOUND).each do |link|
    #     description['error'] = link.content.lstrip if link.content.include? 'Page Not Found'
    # end
    html.xpath(XPATH_ITEM).each {|link|
      puts link
      description['availability'] = link.content.gsub(' ','').gsub('.\n\n\n','').lstrip if link.content.include? 'Stock'
    }
    # html.xpath(XPATH_ITEM).each {|link|
    #   description['price'] = link.content.lstrip
    # }
    description
  end


end