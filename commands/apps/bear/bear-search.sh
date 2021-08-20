#!/bin/bash

# Install Bear via Mac App Store: https://apps.apple.com/us/app/bear/id1091189122

# @raycast.title Search
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Search notes by keyword and/or tag in Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Term", "optional": true, "percentEncoded": true}
# @raycast.argument2 { "type": "text", "placeholder": "Tag", "optional": true, "percentEncoded": true}

if [ ! -z "$1" ]; then
  if [ ! -z "$2" ]; then
    open "bear://x-callback-url/search?term=${1}&tag=${2}"
  else
    open "bear://x-callback-url/search?term=${1}"
  fi
else
  if [ ! -z "$2" ]; then
    open "bear://x-callback-url/search?tag=${2}"
  else
    open "bear://"
  fi
fi
