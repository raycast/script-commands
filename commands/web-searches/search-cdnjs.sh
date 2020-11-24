#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Search cdnjs
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search cdnjs.com for library.
# @raycast.icon images/cloudflare-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Library" }
# @raycast.packageName Web Searches

open "https://cdnjs.com/libraries?q=${1// /%20}"