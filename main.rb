require 'net/http'
require 'uri'
require 'cgi'

def http_get(domain)
  Net::HTTP.get URI(domain)
end


params = {:q => "ruby", :max => 50}
# puts http_get("www.google.com", "/", params)
puts http_get('http://www.ebay.com/lit/v1/item?pbv=1&item=392315084973&si=I3CW%2Fqiszl2XWlmQGBj6U%2BM49Y0%3D&lastaccessed=1561243320000&lvr=0&dl=4&cb=jQuery1708731352142529449_1561243321737&_=1561243321814',
              )