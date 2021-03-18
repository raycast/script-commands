#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Pull Requests
# @raycast.mode inline
# @raycast.description Display number of open pull requests
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
# @raycast.author Faye Sipiano
# @raycast.authorURL https://github.com/FSipiano

require 'json'
require 'net/http'
require 'uri'

# Insert a personal access token (https://github.com/settings/tokens)
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
req.body = '{ "query": "query { viewer { pullRequests(first: 10, states:OPEN) { nodes { title number url } } } }" }'
req_options = {
  use_ssl: uri.scheme == 'https'
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(req)
end

if res.code == '200'
  result = JSON.parse(res.body)
  pull_requests = result['data']['viewer']['pullRequests']['nodes']

  if pull_requests.length == 0
    message = "No open pull requests 🎉"
    puts "\e[#{GREEN}m#{message}\e[0m"
  else
    color = (pull_requests.length <= 5) ? YELLOW : RED
    message = "You have #{pull_requests.length} open pull requests"
    puts "\e[#{color}m#{message}\e[0m"
    pull_requests.each do |pr|
      puts "##{pr['number']} #{pr['title']} (#{pr['url']})"
    end
  end
else
  puts 'Failed loading GitHub pull requests'
  exit(1)
end
