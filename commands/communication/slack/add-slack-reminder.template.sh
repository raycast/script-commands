#!/bin/bash

# API: https://api.slack.com/methods/reminders.add

# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Reminder
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Slack
# @raycast.icon ⏰
# @raycast.argument1 { "type": "text", "placeholder": "What" }
# @raycast.argument2 { "type": "text", "placeholder": "When" }

# Documentation:
# @raycast.description Create a Slack reminder
# @raycast.author Zeb Pykosz
# @raycast.authorURL https://github.com/zebapy

# Configuration

# To create a new API token, do the following:
# 1. Create a new Slack app at https://api.slack.com/authentication/basics
# 2. Add `reminders:write` to the user token scopes
# 3. Install the app to your workplace
# 4. Insert your OAuth access token below
API_TOKEN=""

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
  --data "{ 'text': '$1', 'time': '$2' }" \
  --silent \
  --output /dev/null \
  --show-error \
  --fail \
  "https://slack.com/api/reminders.add"
)

if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to add reminder in Slack"
  exit 1
else 
  echo "Added reminder '$1 $2' in Slack!"
  exit 0
fi
