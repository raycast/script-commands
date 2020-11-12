#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Current Weather
# @raycast.mode inline

# Please be mindful of scalability of wttr.in if adjusting the refreshTime
# (currently limite to one million requests per day).
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Get current weather report from wttr.in.
# @raycast.icon 🌦️

output=$(curl -s https://wttr.in/?format="%c+%f+%w{;}%l")

IFS='{;}' read -ra array <<< "$output"
IFS=',' read -ra location <<< "${array[1]}"

echo "${array[0]} - ${location[0]}"