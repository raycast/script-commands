#!/usr/bin/env ruby


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decrease Brightness
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/elgato.png
# @raycast.packageName Elgato Key Light

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Decrease brightness of Elgato Key Light by 5%.


# Configuration

HOST=""
PORT=""


# Main program

require "json"
require "net/http"
require "uri"

uri = URI("http://#{HOST}:#{PORT}/elgato/lights")
req = Net::HTTP::Get.new(uri)

res = Net::HTTP.start(uri.hostname, uri.port) { |http|
  http.request(req)
}

if res.code == "200"
  result = JSON.parse(res.body)

  first_light = result["lights"].first()
  if first_light.nil?
    puts "Failed parsing first light"
    exit(1)
  end
  
  brightness = first_light["brightness"]
  brightness -= 5
  brightness = brightness.clamp(0, 100)

  uri = URI("http://#{HOST}:#{PORT}/elgato/lights")
  req = Net::HTTP::Put.new(uri)
  req.body = {
    "numberOfLights": 1,
    "lights": [
      {
        "brightness": brightness
      }
    ]
  }.to_json

  res = Net::HTTP.start(uri.hostname, uri.port) { |http|
    http.request(req)
  }

  if res.code == "200"
    puts "Decreased brightness to #{brightness}%"
  else 
    puts "Failed decreasing brightness"
    exit(1)
  end
else 
  puts "Failed loading lights"
  exit(1)
end
