#!/bin/bash

# Dependency: requires jq (https://stedolan.github.io/jq/)
# Install via Homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Is It Up?
# @raycast.mode compact
# @raycast.packageName Developer Utils
#
# Optional parameters:
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "Website" }
#
# Documentation:
# @raycast.description Check if a website is up
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

if ! command -v jq &> /dev/null; then
  echo "jq is required (https://stedolan.github.io/jq/).";
  exit 1;
fi

# Get the url from the user input
url=$1

# Remove any protocol prefix (http:// or https://)
url=${url#*://}

# Remove any www. prefix
url=${url#www.}

# Remove any trailing slash
url=${url%/}

status_code=$(curl --silent "https://isitup.org/${url}.json" | jq '.status_code')

# Sample output:
#
# {
#   "domain": "duckduckgo.com",
#   "port": 80,
#   "status_code": 1,
#   "response_ip": "52.142.124.215",
#   "response_code": 200,
#   "response_time": 0.021
# }

case $status_code in
  1) echo "$1 is up!"
     exit 0
     ;;
  2) echo "$1 is down."
     exit 0
     ;;
  3) echo "Invalid domain: $1"
     exit 1
     ;;
  *) echo "Error: unknown status code ($status_code): $1"
     exit 1
     ;;
esac
