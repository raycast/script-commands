#!/bin/bash

# Required parameters:
# @raycast.author Faris Aziz
# @raycast.authorURL https://github.com/farisaziz12
# @raycast.schemaVersion 1
# @raycast.title Get Tasks
# @raycast.mode fullOutput
# @raycast.packageName Todoist
# @raycast.description Gets All Todoist tasks
# @raycast.needsConfirmation false

# Dependency: requires jq (https://stedolan.github.io/jq/)
# Install via Homebrew: `brew install jq`



# Optional parameters:
# @raycast.icon images/todoist-logo.png

# Get your API Token from: https://todoist.com/prefs/integrations

API_TOKEN=

if ! command -v jq &> /dev/null; then
	echo "jq is required (https://stedolan.github.io/jq/).";
	exit 1;
fi

if [ -z "$API_TOKEN" ]; then
	echo "Todoist API token is missing.";
	exit 1;
fi

TASKS=$(curl -s -X GET \
  https://api.todoist.com/rest/v1/tasks \
  -H "Authorization: Bearer $API_TOKEN")

echo "$TASKS" | jq '.[] | .content'
echo
echo "You have $(echo "$TASKS" | jq 'length') tasks"
