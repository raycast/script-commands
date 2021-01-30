#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in App Store
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/app-store.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

# Documentation
# @raycast.author Andrei Borisov
# @raycast.authorURL https://github.com/andreiborisov
# @raycast.description Search in App Store app

open "macappstore://ax.search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?q=$1"
