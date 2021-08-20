#!/bin/bash

# Dependency: requires jq (https://stedolan.github.io/jq/)
# Install via Homebrew: `brew install jq`

##################################################################
## Set GitHub username and personal access token and uncomment, ##
## and check toggle for detailed output.                        ##
##################################################################

# GitHub username
user=

# GitHub personal access token
access_key=

# Toggle for detailed count
detailed=true

# @raycast.title Unread Notifications
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Display (detailed) number of unread GitHub notifications.

# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
# @raycast.mode inline
# @raycast.packageName GitHub
# @raycast.refreshTime 5m
# @raycast.schemaVersion 1

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
	echo 'None'

elif [ 50 = $count ]; then
	echo '50+ unread notifications'
	
elif $detailed; then
	
	notifications=$(echo "$response" | jq 'group_by(.reason) | map({
		"reason": .[0].reason,
		"total": length
	})')

	function reason_label() {
		local reason=$1
		
		if [[ $reason = "ci_activity" ]]; then
			reason="CI"
		elif [[ $reason = "review_requested" ]]; then
			reason="Review"
		else
			reason="$(tr '[:lower:]' '[:upper:]' <<< ${reason:0:1})${reason:1}"
		fi
			
		echo $reason
	}
	
	echo "$notifications" | jq -c '.[]' | 
	while IFS=$"\n" read -r c; do
		reason=$(echo "$c" | jq -r '.reason')
		reason=$(reason_label $reason)
		total=$(echo "$c" | jq -r '.total')
		echo -n "${reason}:${total} "
	done
	
else
	echo "$count unread notifications"
fi
