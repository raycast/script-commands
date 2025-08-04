#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Remove Paywall
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📰

# Documentation:
# @raycast.description Un-paywall your current safari/chrome tab. Uses archive.is to grab the latest archived page.
# @raycast.author pokie
# @raycast.authorURL https://raycast.com/pokie
# Step 1: Determine frontmost browser (Safari or Chrome)

app=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

if [[ "$app" == "Safari" ]]; then
  url=$(osascript -e 'tell application "Safari" to return URL of front document')
elif [[ "$app" == "Google Chrome" ]]; then
  url=$(osascript -e 'tell application "Google Chrome" to return URL of active tab of front window')
else
  echo "Unsupported front app: $app"
  exit 1
fi

if [[ -z "$url" ]]; then
  echo "Could not determine current tab URL"
  exit 1
fi

enc=$(python3 -c 'import urllib.parse,sys; print(urllib.parse.quote(sys.stdin.read().strip(), safe=""))' <<< "$url")
archive="https://archive.is/latest/$enc"
status=$(curl -s -o /dev/null -w "%{http_code}" "$archive")

if [[ "$status" != "200" && "$status" != "301" && "$status" != "302" ]]; then
  echo "No archive snapshot found (HTTP $status)"
  exit 1
fi

if [[ "$app" == "Safari" ]]; then
  osascript -e "tell application \"Safari\" to set URL of front document to \"$archive\""
else
  osascript -e "tell application \"Google Chrome\" to set URL of active tab of front window to \"$archive\""
fi
