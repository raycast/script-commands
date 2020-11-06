#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Current Weather
# @raycast.mode inline
# @raycast.refreshTime 5m

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Get current weather report from wttr.in.
# @raycast.icon 🌦️

output=$(curl -s https://wttr.in/?format="%c+%f+%w+in+%l")
echo $output