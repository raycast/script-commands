#!/usr/bin/env ruby

# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stocks
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon 📈

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Keep track of your stock portfolio.


# Configuration

SYMBOLS = [
  "AAPL",
  "BYND",
  "TSLA",
]


# Main program

require "json"
require "net/http"
require "uri"

if SYMBOLS.empty?
  puts "No stock symbol provided"
  exit(1)
end

def fetch_stock(symbol)
  uri = URI("https://api.lil.software/stocks?symbol=#{symbol}")
  req = Net::HTTP::Get.new(uri)
  
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  
  res = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http|
    http.request(req)
  }
  
  if res.code == "200"
    result = JSON.parse(res.body)
  
    current = result["current"] 
    previous_close = result["previous_close"]
    
    growth = ((current - previous_close) / previous_close * 100).round(1)
    
    return "#{symbol}: #{current} (#{growth}%)"
  else 
    puts "Failed loading stock"
    exit(1)
  end
end

portfolio = SYMBOLS.map { |symbol| fetch_stock symbol }
puts "#{portfolio * "   "}"