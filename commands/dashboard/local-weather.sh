#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Local Weather
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon ☀️
# @raycast.packageName Local Weather

# Documentation:
# @raycast.description Shows the current local weather, favorite to have a constant weather update 
# @raycast.author lukasoppermann
# @raycast.authorURL https:#twitter.com/lukasoppermann

# configure
UNIT="m" # celsius
# UNIT="u" # fahrenheit

# script inputs
IP=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed -r 's/^"|"$//g')
LOCATION=$(curl  --silent "https://ipapi.co/${IP}/postal/") # for api query
CITY=$(curl  --silent "https://ipapi.co/${IP}/city/") # for output

# output
curl --silent "http://wttr.in/${LOCATION}?format=${CITY}:+%c+%t+(feels+like:+%f)\n&${UNIT}"
