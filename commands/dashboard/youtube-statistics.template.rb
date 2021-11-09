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
# @raycast.description Shows YouTube Subscribers, Views and Videos
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit

require "json"
require "net/http"
require "uri"

# Channel ID is required
# To find your ID please follow instructions here: https://support.google.com/youtube/answer/3250431?hl=en
CHANNEL_ID = ""

# Channel KEY is required
# To create your credentials please follow instructions here: https://developers.google.com/youtube/registering_an_application
CHANNEL_KEY = ""

uri = URI("https://www.googleapis.com/youtube/v3/channels?part=statistics&id=#{CHANNEL_ID}&key=#{CHANNEL_KEY}&part=snippet")

req = Net::HTTP::Get.new(uri)

req_options = {
  use_ssl: uri.scheme == "https",
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http|
  http.request(req)
}

if res.code == "200"
  result = JSON.parse(res.body)
   item = result["items"][0] 
   statistics = item["statistics"]

   title = item["snippet"]["title"]
   subs = statistics["subscriberCount"]
   views = statistics["viewCount"]
   videos = statistics["videoCount"]

  puts "Channel: #{title}, Subs: #{subs}, Views: #{views}, Videos: #{videos}"
else
  puts "Failed loading statistics"
  exit(1)
end
