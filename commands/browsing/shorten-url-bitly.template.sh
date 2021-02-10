#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shorten URL with Bitly
# @raycast.mode compact
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon 🔗

# Documentation:
# @raycast.author Nitin Gupta
# @raycast.authorURL https://twitter.com/gniting
# @raycast.description Transform the clipboard contents to a short Bitly URL

# generate an access token: https://support.bitly.com/hc/en-us/articles/230647907-How-do-I-generate-an-OAuth-access-token-for-the-Bitly-API-
accessToken="put_in_your_access_token_here"
urlFromClipboard=`pbpaste`
result=`curl -s --request GET -G --data-urlencode "longURL=$urlFromClipboard" --data-urlencode "access_token=$accessToken" https://api-ssl.bitly.com/v3/shorten`
statusCode=`echo $result | ruby -r json -e 'puts JSON.parse(STDIN.read)["status_code"]'`
if [[ "$statusCode" == "200" ]]
then
    echo $result | ruby -r json -e 'puts JSON.parse(STDIN.read)["data"]["url"]' | pbcopy; echo -n `pbpaste`
else
    echo $result | ruby -r json -e 'puts "ERROR: " + JSON.parse(STDIN.read)["status_txt"]'
fi
