#!/bin/bash

# @raycast.title Current Weather
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Get current weather report from [wttr.in](https://wttr.in/).

# @raycast.icon 🌦️
# @raycast.mode inline
# @raycast.packageName Dashboard
# @raycast.schemaVersion 1

## Please be mindful of scalability of wttr.in if adjusting the refresh time:
## currently limited to one million requests per day
## (see https://github.com/chubin/wttr.in/blob/master/share/static/malformed-response.html).
# @raycast.refreshTime 1h

# get your ip
IP=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed -r 's/^"|"$//g')

# configure
UNIT="m" # celsius
# UNIT="u" # fahrenheit

# Automatic location
LOCATION=$(curl --silent "https://ipapi.co/${IP}/postal/") # automatic location
CITY=$(curl --silent "https://ipapi.co/${IP}/city/") # for output
# Manual location
# LOCATION="Berlin" # use this if you want to manually set your location
# CITY="${LOCATION}" 

curl --silent "https://wttr.in/${LOCATION}?format=${CITY}:+%c+%f+%w&${UNIT}"
