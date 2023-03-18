#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Task
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/todoist-logo.png
# @raycast.packageName Todoist
# @raycast.argument1 { "type": "text", "placeholder": "Call Mom Tomorrow at 5" }

# Documentation: 
# @raycast.description Create Task
# @raycast.author Faris Aziz
# @raycast.authorURL https://github.com/farisaziz12

# Get your API Token from: https://todoist.com/prefs/integrations

API_TOKEN="APITOKENHERE"

if [ -z "$API_TOKEN" ]; then
	echo "Todoist API token is missing.";
	exit 1;
fi

TASK="$1"

if [[ $TASK != "" ]]; then
    curl "https://api.todoist.com/rest/v2/tasks" \
    	-X POST \
    	--data '{"content": "'"$TASK"'"}' \
    	-H "Content-Type: application/json" \
    	-H "Authorization: Bearer $API_TOKEN"

	echo "Task Created" # These tasks will show up in your inbox
else
	echo "Please specify a task"
fi
