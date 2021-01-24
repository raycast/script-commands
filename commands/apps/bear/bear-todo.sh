#!/bin/bash

# @raycast.title Open Todos
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Open the Todo section in Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Search Query", "optional": true, "percentEncoded": true}

open "bear://x-callback-url/todo?search=${1}"
