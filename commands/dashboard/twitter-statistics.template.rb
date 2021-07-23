#!/usr/bin/env ruby

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename, set a bearer token and
# specify your Twitter username.


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Twitter Statistics
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName Twitter
# @raycast.icon images/twitter.png

# Documentation:
# @raycast.description Shows the followers, favorites and friends count of your Twitter account.
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann


# Configuration

# Get a new bearer token from https://developer.twitter.com
BEARER_TOKEN = ""

# Twitter username
USER_NAME = "raycastapp"


# Main program

require "json"
require "net/http"
require "uri"

if BEARER_TOKEN.empty?
  puts "No bearer token provided"
  exit(1)
end

uri = URI("https://api.twitter.com/1.1/users/show.json?screen_name=#{USER_NAME}")
req = Net::HTTP::Get.new(uri)
req["Authorization"] = "Bearer #{BEARER_TOKEN}"

req_options = {
  use_ssl: uri.scheme == "https",
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http|
  http.request(req)
}

if res.code == "200"
  result = JSON.parse(res.body)

  followers_count = result["followers_count"]
  favorites_count = result["favorites_count"]
  friends_count = result["friends_count"]

  puts "#{followers_count} Followers, #{favorites_count} Favorites and #{friends_count} Friends"
else
  puts "Failed loading statistics"
  exit(1)
end
