#!/bin/bash

# API: https://slack.com/api/dnd.endDnd

# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Slack DND
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Slack
# @raycast.icon images/slack-logo.png

# Documentation:
# @raycast.description Clear DND Status in Slack
# @raycast.author Sam Ching
# @raycast.authorURL https://github.com/samching


# Configuration

# To create a new API token, do the following:
# 1. Create a new Slack app at https://api.slack.com/authentication/basics
# 2. Add `dnd:write` to the user token scopes
# 3. Install the app to your workplace
# 4. Insert your OAuth access token below
API_TOKEN="XXXXXX"


# Main program
if [[ -z "$API_TOKEN" ]]
then 
  echo "No API token provided"
  exit 1
fi

RESPONSE=$(
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $API_TOKEN" \
  --request POST \
  --silent \
  --show-error \
  --fail \
  "https://slack.com/api/dnd.endDnd"
) 

if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to clear DND status in Slack"
  exit 1
else 
  echo "Cleared DND status in Slack"
  exit 0
fi
