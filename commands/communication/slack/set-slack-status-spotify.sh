#!/bin/bash

# API: https://api.slack.com/methods/users.profile.set

# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Status in Slack to Spotify Song
# @raycast.mode inline
# @raycast.refreshTime 30s

# Optional parameters:
# @raycast.packageName Slack
# @raycast.icon ../../media/images/spotify-logo.png

# Documentation:
# @raycast.description Set your status in Slack to a song currently playing in Spotify.
# @raycast.author alongat
# @raycast.authorURL https://github.com/alongat

# Configuration
# To create a new API token, do the following:
# 1. Create a new Slack app at https://api.slack.com/authentication/basics
# 2. Add `users.profile:write` to the user token scopes
# 3. Install the app to your workplace
# 4. Insert your OAuth access token below
# 5. Fill you OFFICE_WIFI + HOME_WIFI - this will set different emoji when WFH vs WFO

# SLACK Token
API_TOKEN="XXXX"

# Song playing on Spotify
SONG="" 

# Minutes until the the status will expire (Empty string will not expire the status)
STATUS_EXPIRATION_IN_MINUTES="2"

# Lock is used to know if this script updated the status in slack, so not to just clear the status.
LOCK="spotify.lock"

# Define home and office WiFi
HOME_WIFI="HOME-WIFI"
OFFICE_WIFI="OFFICE-WIFI"

# Set default emoji according to the WiFi network
function setDefaultEmoji() {
  wifi_name=`/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}'`
  if [[ "$wifi_name" == " $HOME_WIFI" ]]; then
    DEFAULT_EMOJI=":house_with_garden:"
  elif [[ "$wifi_name" == " $OFFICE_WIFI" ]]; then
    DEFAULT_EMOJI=":office:"
  fi
}

function setExperation() {
  if [[ -z "$STATUS_EXPIRATION_IN_MINUTES" ]]
  then
    STATUS_EXPIRATION=0
  else 
    CURRENT_UNIX_TIME=$(date +%s)
    STATUS_EXPIRATION=$(($CURRENT_UNIX_TIME + ($STATUS_EXPIRATION_IN_MINUTES * 60)))
  fi
}

function getSongAndState() {
  SONG="$(osascript -e 'tell application "Spotify" to artist of current track & " - " & name of current track' | cut -c1-99)"
  STATE=$(osascript -e 'tell application "Spotify" to player state')
  STATUS_EMOJI=":heads-down:"
}

function resetStatus() {
  if [ ! -f "$LOCK" ]; then
    echo "$LOCK not exists. doing nothing"
    return
  fi
  echo 'Resetting status'
  STATUS_EMOJI="$DEFAULT_EMOJI"
  SONG=""
  STATUS_EXPIRATION_IN_MINUTES="480" # Default status is set for 8 hours
  setStatus
  rm $LOCK
}

function setStatus() {
  if [ ! -f "$LOCK" ]; then
    echo "$LOCK not exists. doing nothing"
    return
  fi
  setExperation
  RESPONSE=$(
    curl \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer $API_TOKEN" \
      --request POST \
      --data "{ 'profile': { 'status_text': '$SONG', 'status_emoji': '$STATUS_EMOJI', 'status_expiration': $STATUS_EXPIRATION } }" \
      --silent \
      --show-error \
      --fail \
      "https://slack.com/api/users.profile.set"
    )
}

# Main program
if [[ -z "$API_TOKEN" ]]
then 
  echo "No API token provided"
  exit 1
fi

pgrep Spotify > /dev/null
if [ $? -ne 0 ]; then
  echo 'Spotify is not running, exiting'
  resetStatus
  exit 0
fi

setDefaultEmoji
getSongAndState
if [[ "$STATE" != "playing" ]]; then
  resetStatus
else
  touch $LOCK
  setStatus
fi

if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to set status in Slack"
  exit 1
else 
  echo "Status set to $STATUS_EMOJI : $SONG"
  exit 0
fi