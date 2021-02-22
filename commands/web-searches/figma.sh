#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Figma
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/figma.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

# Documentation:
# @raycast.description Search files in Figma
# @raycast.author Tanguy Le Stradic
# @raycast.authorURL https://github.com/tanguyls

# Configuration

# To retrieve your Figma team_id, do the following:
# 1. Go to https://www.figma.com/files
# 2. Click on "Search"
# 3. The current URL should now have an 18-digit id, that's your team_id. If you're using a personal workspace, leave the below variable blank.
TEAM_ID=""

open "https://www.figma.com/files/$TEAM_ID/search?model_type=files&q=${1}"
