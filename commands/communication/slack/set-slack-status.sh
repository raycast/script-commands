#!/bin/bash

# How to use this script?
# It's a template which needs further setup. Duplicate the file, 
# remove `.template.` from the filename and set an API token.
# Optionally, adjust the status text and emoji as well as 
# the command title and icon to fit your Slack status.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Status to Coffee
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Slack
# @raycast.icon ☕️

# Documentation:
# @raycast.description Set your status in Slack.
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann

# To create a new API token, do the following:
# 1. Create a new Slack app at https://api.slack.com/authentication/basics
# 2. Add `users.profile:write` to the user token scopes
# 3. Install the app to your workplace
# 4. Insert your OAuth access token below
API_TOKEN=""

# Short status text (max. 100 characters)
STATUS_TEXT="Coffee"

# String referencing an emoji enabled for the Slack team
STATUS_EMOJI=":coffee:"

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
  --data "{ 'profile': { 'status_text': '$STATUS_TEXT', 'status_emoji': '$STATUS_EMOJI' } }" \
  --silent \
  --show-error \
  --fail \
  "https://slack.com/api/users.profile.set"
) 

if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to set status in Slack"
  exit 1
else 
  echo "Set status to coffee in Slack"
  exit 0
fi