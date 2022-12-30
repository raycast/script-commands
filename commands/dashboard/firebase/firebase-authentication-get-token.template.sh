#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# !!! This script is only template, you can use it to write own script to get your data from Firebase project !!!
# If you use Firebase email and password authentication service, this script generates an authentication token
# and copy it to your clipboard.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Authorization Token
# @raycast.mode compact
# @raycast.packageName Firebase Authentication

# Optional parameters:
# @raycast.icon images/firebase.png
#
# Documentation:
# @raycast.description Get token from Firebase Authentication service
# @raycast.author João Melo
# @raycast.authorURL https://github.com/joaopcm


# you can find API_KEY on "Project settings -> General" page in Firebase
WEB_API_KEY=""
# you need to create an user with email and password on "Authentication -> Users" page in Firebase
EMAIL=""
PASSWORD=""

if ! jq --version download &> /dev/null; then
    echo "download jq is required (https://stedolan.github.io/jq/).";
    exit 1;
fi

if [ -z "$WEB_API_KEY" ] || [ -z "$EMAIL" ] || [ -z "$PASSWORD" ]; then
    echo "Error: You must provide WEB_API_KEY, EMAIL, and PASSWORD variables"
    exit 1
fi

# Generate the request body
json_data=$( jq -n -c \
    --arg email "$EMAIL" \
    --arg password "$PASSWORD" \
    --arg returnSecureToken true '$ARGS.named' )

# Get data from Firebase Authentication service and copy the token to clipboard
curl -X POST \
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$WEB_API_KEY" \
    --header 'Accept: */*' \
    --header 'User-Agent: Raycast' \
    --header 'Content-Type: application/json' \
    --data-raw "$json_data" | jq -r '.idToken' | pbcopy

echo 'Authorization token copied to your clipboard!'
