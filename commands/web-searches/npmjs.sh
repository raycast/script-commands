#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search npm Packages
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/npmjs.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "package name" }

open "https://www.npmjs.com/search?q=${1// /%20}"
