#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Swift Package Index
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/spi.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true, "optional": true }

# Documentation
# @raycast.author The Swift Package Index
# @raycast.authorURL https://swiftpackageindex.com
# @raycast.description Search for Swift packages in the Swift Package Index.

if [[ -z "$1" ]]
then 
  open "https://swiftpackageindex.com/"
else
  open "https://swiftpackageindex.com/search?query=$1"
fi
