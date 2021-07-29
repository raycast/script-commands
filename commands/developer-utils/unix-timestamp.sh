#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Epoch Unix Timestamp
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Copy the current epoch Unix timestamp.
# @raycast.packageName Developer Utils
# @raycast.icon ⏱️

echo -n $(date +"%s") | pbcopy
echo "Unix timestamp copied"
