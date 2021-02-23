#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search LinkedIn
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/linkedin.png
# @raycast.argument1 { "type": "text", "placeholder": "Search for?", "percentEncoded": true}

# Documentation:
# @raycast.author Nitin Gupta
# @raycast.authorURL https://twitter.com/gniting
# @raycast.description Search LinkedIn

open "https://www.linkedin.com/search/results/all/?keywords=${1}"
