#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Open Pull Requests
# @raycast.mode fullOutput
# @raycast.description Display (detailed) GitHub pull requests
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
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

uri = URI('https://api.github.com/graphql')
req = Net::HTTP::Post.new(uri)
req['Authorization'] = "token #{API_TOKEN}"
req.body = '{ "query": "query { viewer { pullRequests(first: 10 states: OPEN) { nodes { baseRepository { name } title number url } } } }" }'
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
    puts 'No open pull requests 🎉'
  else
    puts "You have #{pull_requests.length} open pull requests"
    pull_requests.each do |pr|
      puts "##{pr['number']} #{pr['title']} (#{pr['url']})"
    end
  end
else
  puts 'Failed loading GitHub pull requests'
  exit(1)
end
