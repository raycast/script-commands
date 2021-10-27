#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Review Requests
# @raycast.mode inline
# @raycast.description Display number of Pull Requests requesting your review
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
#
# Conditional parameters:
# @raycast.refreshTime 5m
#
# Credits
# @raycast.author Vince Picone
# @raycast.authorURL https://github.com/vpicone

require 'json'
require 'net/http'
require 'uri'

# Insert a personal access token (https://github.com/settings/tokens)
# No additional permissions are required, leave all the options unchecked
API_TOKEN = ''

if API_TOKEN.empty?
  puts 'No API token provided'
  exit(1)
end

RED = 31
GREEN = 32
YELLOW = 33


uri = URI('https://api.github.com/graphql')
req = Net::HTTP::Post.new(uri)
req['Authorization'] = "token #{API_TOKEN}"
req.body = '{ "query": "query {search(query:\"type:pr is:open user-review-requested:@me\",type:ISSUE,first:10){issueCount edges{node{...on PullRequest{number title url}}}}}" }'
req_options = {
  use_ssl: uri.scheme == 'https'
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(req)
end

if res.code == '200'
  result = JSON.parse(res.body)

  review_requests = result['data']['search']['edges']
  review_requests_count = result['data']['search']['issueCount']

  if review_requests_count == 0
    message = "No open review requests 🎉"
    puts "\e[#{GREEN}m#{message}\e[0m"
  else
    color = (review_requests_count <= 5) ? YELLOW : RED
    message = "You have #{review_requests_count} open review requests"
    puts "\e[#{color}m#{message}\e[0m"
    review_requests.each do |pr|
      puts "##{pr['node']['number']} #{pr['node']['title']} (#{pr['node']['url']})"
    end
  end
else
  puts 'Failed loading GitHub review requests'
  exit(1)
end
