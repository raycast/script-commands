#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Short URL
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/shlink.png
# @raycast.packageName Shlink
# @raycast.argument2 { "type": "text", "placeholder": "URL", "optional": true, "percentEncoded": false }

# Documentation:
# @raycast.author Eliot Hertenstein
# @raycast.description Create a short URL using Shlink
# @raycast.authorURL https://github.com/eIiot

## * CONFIGURE - REPLACE THESE VALUES * ##
BASEURL="<-- BASE URL -->" # Base URL for the short url. Remove any trailing slash or http(s)://
PROTOCOL="https://$BASEURL" # Use http or https
APIKEY="<-- API KEY -->" # API key for the short url. See https://shlink.io/documentation/api-docs/authentication/
TAG="raycast" # Tag for the short url. Set to "" to disable
## * END CONFIG * ##

if ! command -v jq &> /dev/null; then
      echo "jq is required (https://stedolan.github.io/jq/).";
      exit 1;
fi

if [ -z "$1" ]; then
    URL=$(pbpaste)
else
    URL=$1
fi

if [[ $URL =~ ^https?://[a-zA-Z0-9./?=_-]*$ ]]; then
    SHORT_URL=$(curl --location --silent --request POST ''"$PROTOCOL"'/rest/v1/short-urls' \
    --header 'Content-Type: application/json' \
    --header 'X-Api-Key: '"$APIKEY"'' \
    --data-raw '{
        "longUrl": "'"$URL"'",
        "validateUrl": false,
        "tags": [
            "'$TAG'"
        ],
        "findIfExists": true,
        "domain": "'"$BASEURL"'"
    }' | jq -r '.shortUrl')

    if [ -n "$SHORT_URL" ]; then
        echo "$SHORT_URL" | pbcopy
        echo "Copied $SHORT_URL to your clipboard"
    else 
        echo "Error: Could not create short URL"
        exit 1
    fi

else
    echo "Invalid URL \"$URL\""
    exit 1
fi
