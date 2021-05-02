#!/bin/bash

# Dependency: requires jq (https://stedolan.github.io/jq/)
# Install via Homebrew: `brew install jq`

####################################################
## Set GitHub username and personal access token. ##
####################################################

# GitHub username
user=

# GitHub personal access token
access_key=

# @raycast.title Create GitHub Gist from Clipboard
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Create a GitHub Gist from clipboard contents and copy Gist URL.

# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
# @raycast.mode compact
# @raycast.needsConfirmation true
# @raycast.packageName GitHub
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

clipboard=$(pbpaste)
gist_content="$( jq -nc --arg str "$clipboard" '{ "public": false, "files": { "gistfile1.txt": { "content": $str } } }' )"

auth=$(echo -n "$user:$access_key" | base64)
response=$( curl -s -X POST -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Basic $auth" https://api.github.com/gists -d "$gist_content" )

echo "$response" | jq -r '.html_url' | pbcopy
echo "Created gist and copied URL"
