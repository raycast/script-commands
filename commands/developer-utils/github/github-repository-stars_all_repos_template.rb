#!/usr/bin/env ruby

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename, set an API token.

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
# @raycast.description Show statistics of your GitHub repositories.
# @raycast.author Valdir Junior
# @raycast.authorURL https://github.com/valdirjunior011 

# Configuration

# Insert a token with access to your repository (https://github.com/settings/tokens)
$api_token = ""

# Owner of the repositories
$owner = ""

# Main program

require "json"
require "net/http"
require "uri"

if $api_token.nil?
  puts "API token not provided"
  exit(1)
end

uri = URI("https://api.github.com/users/#{$owner}/repos")
req = Net::HTTP::Get.new(uri)
req["Authorization"] = "token #{$api_token}"

req_options = {
  use_ssl: uri.scheme == "https",
}

res = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http|
  http.request(req)
}

if res.code == "200"
  repositories = JSON.parse(res.body)

  total_stars = 0
  total_forks = 0
  total_subscribers = 0

  repositories.each do |repo|
    repo_name = repo["full_name"]
    url = repo["html_url"]

    repo_uri = URI("https://api.github.com/repos/#{repo_name}")
    repo_req = Net::HTTP::Get.new(repo_uri)
    repo_req["Authorization"] = "token #{$api_token}"

    repo_res = Net::HTTP.start(repo_uri.hostname, repo_uri.port, req_options) { |http|
      http.request(repo_req)
    }

    if repo_res.code == "200"
      result = JSON.parse(repo_res.body)

      stars = result["stargazers_count"]
      forks = result["forks_count"]
      subscribers = result["subscribers_count"]

      total_stars += stars
      total_forks += forks
      total_subscribers += subscribers

    else
      puts "Failed loading statistics for #{repo_name}"
    end
  end

  puts "Owner: #{$owner} Total Stars: #{total_stars}, Forks: #{total_forks}, Subs: #{total_subscribers}"
else
  puts "Failed loading repositories for #{$owner}"
end