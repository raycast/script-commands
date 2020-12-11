#!/bin/bash

# @raycast.title Search Unsplash
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search [Unsplash](https://unsplash.com).

# @raycast.icon images/unsplash-logo.png
# @raycast.iconDark images/unsplash-logo-iconDark.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Query" }

open "https://unsplash.com/s/photos/${1// /-}"