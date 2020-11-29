#!/usr/bin/env ruby

# How to use this script?
# It's a template which needs further setup. Duplicate the file, 
# remove `.template.` from the filename, set an API token and 
# specify your repository.


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Repository Statistics
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon ⭐️

# Documentation:
# @raycast.description Show statistics of your GitHub repository.
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann


# Configuration

# Insert a token with access to your repository (https://github.com/settings/tokens)
$api_token = ""

# Slug of the owner and repository
$repository = "raycast/script-commands"


# Main program

require "json"
require "net/http"
require "uri"

if $api_token.empty?
  puts "No API token provided"
  exit(1)
end

uri = URI("https://api.github.com/repos/#{$repository}")
req = Net::HTTP::Get.new(uri)
req["Authorization"] = "token #{$api_token}"

req_options = {
  use_ssl: uri.scheme == "https",
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http|
  http.request(req)
}

if res.code == "200"
  result = JSON.parse(res.body)

  stars = result["stargazers_count"] 
  forks = result["forks_count"] 
  subscribers = result["subscribers_count"] 
  
  puts "#{stars} Stars, #{forks} Forks and #{subscribers} Watchers"
else 
  puts "Failed loading GitHub repository"
  exit(1)
end
