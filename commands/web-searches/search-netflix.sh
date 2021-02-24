#!/bin/bash

# @raycast.title Search Netflix
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search Netflix.

# @raycast.icon images/netflix-logo.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true }

open "https://www.netflix.com/search?q=${1}"