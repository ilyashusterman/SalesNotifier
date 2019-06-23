require_relative 'sales_notifier'
require_relative 'markets/models/product'

if $PROGRAM_NAME == __FILE__
  products = [Product.new(item_id = 392315084973, market = 'Ebay')]
  sales = SalesNotifier.new(products)
  puts sales.get_sales
end