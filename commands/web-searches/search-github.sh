#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Search GitHub
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search GitHub.
# @raycast.icon images/cloudflare-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
# @raycast.packageName Web Searches

open "https://github.com/search?q=${1// /%20}"