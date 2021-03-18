#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Pull Requests
# @raycast.mode inline
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
#
# Conditional parameters:
# @raycast.refreshTime 5m

require 'json'
require 'net/http'
require 'uri'

API_TOKEN = ''
RED = 31
GREEN = 32
YELLOW = 33


if API_TOKEN.empty?
  puts 'No API token provided'
  exit(1)
end

uri = URI('https://api.github.com/graphql')
req = Net::HTTP::Post.new(uri)
req['Authorization'] = "token #{API_TOKEN}"
req.body = '{ "query": "query { viewer { pullRequests(first: 10, states:OPEN) { nodes { title number url } }}}" }'
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
    MESSAGE = "No open pull requests 🎉"
    puts "\e[#{GREEN}m#{MESSAGE}\e[0m"
  elsif pull_requests.length <= 5
    MESSAGE = "You have #{pull_requests.length} open pull requests"
    puts "\e[#{YELLOW}m#{MESSAGE}\e[0m"
    pull_requests.each do |pr|
      puts "##{pr['number']} #{pr['title']} (#{pr['url']})"
    end
  elsif pull_requests.length > 5
    MESSAGE = "You have #{pull_requests.length} open pull requests"
    puts "\e[#{RED}m#{MESSAGE}\e[0m"
    pull_requests.each do |pr|
      puts "##{pr['number']} #{pr['title']} (#{pr['url']})"
    end
  end
else
  puts 'Failed loading GitHub pull requests'
  exit(1)
end
