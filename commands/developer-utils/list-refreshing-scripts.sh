#!/bin/bash

# @raycast.title List Refreshing Scripts
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description List Script Commands that have a refresh time.

# @raycast.schemaVersion 1
# @raycast.mode fullOutput

## Depending on your Script Command directory structure, you may need to set 
## the @raycast.currentDirectoryPath meta value.
# @raycast.currentDirectoryPath

# Use a variable so not listed in search results.
search="@raycast."
search+="refreshTime "

pwd=$(pwd)
results=$(grep -r "$search" . | sort)

## Contributions welcome to improve output.
results=$(echo "${results//# ${search}/ }")
results=$(echo "${results//\/\/ ${search}/ }")

if [ -z "$results" ]; then
	echo "No refreshing scripts found in \"${pwd}\"."
	exit 0;
fi

count=$(echo "$results" | wc -l | xargs)

echo "$count refreshing scripts found in \"$pwd\":"
echo ""
echo "$results"