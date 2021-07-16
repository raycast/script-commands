#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Open Google Meet
# @raycast.mode silent
# @raycast.packageName Google
# @raycast.icon images/logo.png
# @raycast.author Mujib Azizi
# @raycast.authorURL https://github.com/mujibazizi
# @raycast.description Start a Google Meet session

open https://meet.google.com/new

MAX_TRIES=10
TRIES=0

DEFAULT_BROWSER=$(defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist | awk -F'\"' '/http;/{print window[(NR)-1]}{window[NR]=$2}')

get_url () {
  if [ "$DEFAULT_BROWSER" = "com.google.chrome" ]; then
    URL=$(osascript -e 'tell application "Chrome" to URL of active tab of front window as text')
  elif [ "$DEFAULT_BROWSER" = "com.brave.browser" ]; then
    URL=$(osascript -e 'tell application "Brave" to URL of active tab of front window as text')
  elif [ "$DEFAULT_BROWSER" = "com.apple.safari" ]; then
    URL=$(osascript -e 'tell application "Safari" to return URL of front document')
  elif [ "$DEFAULT_BROWSER" = "org.mozilla.firefox" ]; then
    URL=$(osascript -e 'tell applcation "Firefox" to activate')
    echo "There is no support for Firefox yet. Please copy the URL manually"
    exit 0
  fi
}

while true; do
  ((TRIES++))

  # Allow some time between each iteration to perform an attempt
  sleep 1

  # As we're doing `while true`, we do want to make sure we can
  # exit the script when we feel we've tried too many times.
  if [[ "$TRIES" -gt "$MAX_TRIES" ]]; then
    echo "Could not copy Google Meet url"
    break;
  fi

  get_url

  # First, we'll check if we are still on the Google Meet page.
  if [[ $URL != "https://meet.google.com"* ]]; then
    continue
  fi

  # Next, we want to make sure it's not still loading.
  if [[ $URL == *"new"* ]]; then
    continue
  fi

  echo $URL | pbcopy
  echo "Copied Google Meet url"
  break
done