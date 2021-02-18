#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Create Google Meet meeting
# @raycast.mode silent
# @raycast.packageName Google
# @raycast.icon images/logo.png
# @raycast.author Mujib Azizi
# @raycast.authorURL https://github.com/mujibazizi
# @raycast.description Start a Google Meet session

open https://meet.new

MAX_TRIES=20
TRIES=0


while true; do
  ((TRIES++))

  # As we're doing `while true`, we do want to make sure we can
  # exit the script when we feel we've tried too many times.
  if [[ "$TRIES" -gt "$MAX_TRIES" ]]; then
    echo "Could not copy Google Meet url"
    break;
  fi

  URL=$(osascript -e 'tell application "Chrome" to URL of active tab of first window as text')

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