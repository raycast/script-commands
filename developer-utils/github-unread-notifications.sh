#!/bin/bash

##################################################################
## Set GitHub username and personal access token and uncomment. ##
##################################################################

# GitHub username
# user=

# GitHub personal access token
# access_key=

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unread Notifications
# @raycast.mode inline
# @raycast.refreshTime 5m

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Number of unread GitHub notifications.
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png

if [ -z ${user+x} ]; then
	echo "GitHub username is missing.";
	exit 1;
fi

if [ -z ${access_key+x} ]; then
	echo "GitHub personal access token is missing.";
	exit 1;
fi

if ! command -v jq &> /dev/null; then
	echo "jq is required (https://stedolan.github.io/jq/).";
	exit 1;
fi

auth=$(echo -n "$user:$access_key" | base64)
response=$(curl -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: Basic $auth" "https://api.github.com/notifications?per_page=50")
count=$(echo "$response" | jq -r 'length')

if [ 0 = $count ]; then
	echo 'No unread notifications'
elif [ 50 = $count ]; then
	echo '50+ unread notifications'
else
	echo "$count unread notifications"
fi