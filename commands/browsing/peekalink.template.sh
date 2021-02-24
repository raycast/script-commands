#!/bin/bash

############################################
## Set API key.                           ##
## https://www.peekalink.io/auth/register ##
############################################

api_key=

# @raycast.title Peek a link
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Use [Peekalink.io](https://peekalink.io) API to peek specified URL.

# @raycast.icon images/peekalink-logo.png
# @raycast.mode fullOutput
# @raycast.packageName Internet
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if [ -z ${api_key+x} ]; then
	echo "API key is missing.";
	exit 1;
fi

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $1 =~ $regex ]]; then 
	curl -s 'https://api.peekalink.io' -H "X-API-Key: ${api_key}" -H "Content-Type: application/json" -d '{ "link": "'"${1}"'" }' | python -m json.tool
	exit 0;
fi

echo "Input is not a valid URL."