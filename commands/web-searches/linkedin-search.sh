#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title LinkedIn Search
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName LinkedIn Search
# @raycast.icon ./images/linkedin-icon.png
# @raycast.argument1 { "type": "text", "placeholder": "search term", "percentEncoded": true }

# Documentation:
# @raycast.description Search LinkedIn
# @raycast.author Trevin Chow
# @raycast.authorURL https://links.dev/trevin

open "https://www.linkedin.com/search/results/all/?keywords=$1"

