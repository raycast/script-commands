#!/bin/bash

# Required parameters:
# @raycast.author Faris Aziz
# @raycast.authorURL https://github.com/farisaziz12
# @raycast.schemaVersion 1
# @raycast.title Create Task
# @raycast.mode silent
# @raycast.packageName Todoist
# @raycast.description Creates Todoist task
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "Buy Milk", "optional": false, }


# Optional parameters:
# @raycast.icon images/todoist-logo.png

# Get your API Token from: https://todoist.com/prefs/integrations

API_TOKEN=

if [ -z "$API_TOKEN" ]; then
	echo "Todoist API token is missing.";
	exit 1;
fi

TASK="$1"

if [[ $TASK != "" ]]; then
    curl -s "https://api.todoist.com/rest/v1/tasks" \
        -X POST \
        --data '{"content": "'$TASK'", "due_string": "Tomorrow"}' \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_TOKEN"
    echo "Task Created" # These tasks will show up in your inbox
else
    echo "Please specify a task"
fi
