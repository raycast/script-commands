#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title YouTube Statistics
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName YouTube Statistics
# @raycast.icon images/youtube.png

# Documentation:
# @raycast.description Shows YouTube Subscribers
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit

require "json"
require "net/http"
require "uri"

# Channel ID is required
CHANNEL_ID = ""

# Channel key is also required and to get get one please follow
# https://developers.google.com/youtube/registering_an_application
CHANNEL_KEY = ""

uri = URI("https://www.googleapis.com/youtube/v3/channels?part=statistics&id=#{CHANNEL_ID}&key=#{CHANNEL_KEY}")

req = Net::HTTP::Get.new(uri)

req_options = {
  use_ssl: uri.scheme == "https",
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http|
  http.request(req)
}


if res.code == "200"
  result = JSON.parse(res.body)

  subs = result["items"][0]["statistics"]["subscriberCount"]
  views = result["items"][0]["statistics"]["viewCount"]
  videos = result["items"][0]["statistics"]["videoCount"]


  puts "Subs: #{subs}, Views: #{views}, Videos: #{videos}"
else
  puts "Failed loading statistics"
  exit(1)
end
