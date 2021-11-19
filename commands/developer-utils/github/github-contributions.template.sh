#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Contributions
# @raycast.mode inline
# @raycast.refreshTime 2h

# Optional parameters:
# @raycast.packageName GitHub Contributions
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png

# Documentation:
# @raycast.description Show GitHub user contributions from the current year
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit

# GitHub username is required
username=""

url="https://github.com/users/${username}/contributions"
result=$(curl -s $url )
resultFilter=$(echo "$result" | sed -n -e '/<h2 class="f4 text-normal mb-2">/,/<\/h2>/p')
resultCleanup=$(echo "$resultFilter" | sed -e 's/<[^>]*>//g')

echo $resultCleanup
