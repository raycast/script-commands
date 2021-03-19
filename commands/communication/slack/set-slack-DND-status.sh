#!/bin/bash

# API: https://slack.com/api/dnd.setSnooze


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set DND Status
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Slack
# @raycast.argument1 { "type": "text", "placeholder": "number of minutes", "percentEncoded": true, "optional": true}
# @raycast.icon images/slack-logo.png

# Documentation:
# @raycast.description Set your DND status in Slack
# @raycast.author Sam Ching
# @raycast.authorURL https://github.com/samching


# Configuration

# To create a new API token, do the following:
# 1. Create a new Slack app at https://api.slack.com/authentication/basics
# 2. Add `dnd:write` to the user token scopes
# 3. Install the app to your workplace
# 4. Insert your OAuth access token below
API_TOKEN="XXXXXX"

# Default expiration (in mins)
DEFAULT_STATUS_EXPIRATION_IN_MINUTES=30

# Minutes until the the status will expire
STATUS_EXPIRATION_IN_MINUTES="${1}"


# Main program

if [[ -z "$API_TOKEN" ]]
then 
  echo "No API token provided"
  exit 1
fi

if [[ -z "$STATUS_EXPIRATION_IN_MINUTES" ]]
then
  STATUS_EXPIRATION_IN_MINUTES=$DEFAULT_STATUS_EXPIRATION_IN_MINUTES # default expiration
fi

RESPONSE=$(
curl \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --request POST \
  --data "token=$API_TOKEN&num_minutes=$STATUS_EXPIRATION_IN_MINUTES" \
  --silent \
  --show-error \
  --fail \
  "https://slack.com/api/dnd.setSnooze"
) 

if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to set status in Slack"
  exit 1
else 
  echo "Turned DND on in Slack for $STATUS_EXPIRATION_IN_MINUTES" minutes
  exit 0
fi