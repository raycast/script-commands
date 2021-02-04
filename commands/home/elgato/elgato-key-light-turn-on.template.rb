#!/usr/bin/env ruby

# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Turn On
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/elgato.png
# @raycast.packageName Elgato Key Light

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Turn on Elgato Key Light.

# Configuration

HOST=""
PORT=""


# Main program

require "json"
require "net/http"
require "uri"

if HOST.empty? || PORT.empty?
  puts "No host or port provided"
  exit(1)
end

uri = URI("http://#{HOST}:#{PORT}/elgato/lights")
req = Net::HTTP::Put.new(uri)
req.body = {
  "numberOfLights": 1,
  "lights": [
    {
      "on": 1
    }
  ]
}.to_json

res = Net::HTTP.start(uri.hostname, uri.port) { |http|
  http.request(req)
}

if res.code == "200"
  puts "Turned on light"
else 
  puts "Failed turning on light"
  exit(1)
end
