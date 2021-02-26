#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Search Swift Code
# @raycast.mode silent

# @raycast.icon ./images/swift.png
# @raycast.packageName Web Searches

# @raycast.argument1 { "type": "text", "placeholder": "Query", "urlencoded": true, "optional": true }

if [[ -z "$1" ]]
then 
  QUERY=$(pbpaste)
else
  QUERY=$1
fi

open "https://github.com/search?q=$QUERY&l=Swift&type=code"