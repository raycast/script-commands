#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search LinkedIn
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon https://s3-us-west-2.amazonaws.com/iconduck.prod/assets.00/asstqik48oc9
# @raycast.argument1 { "type": "text", "placeholder": "Search for?" }

# Documentation:
# @raycast.author Nitin Gupta
# @raycast.authorURL https://twitter.com/gniting
# @raycast.description Search LinkedIn

open "https://www.linkedin.com/search/results/all/?keywords=${1// /%20}"
