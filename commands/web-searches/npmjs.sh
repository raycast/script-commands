#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search npm Packages
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/npmjs.png
# @raycast.argument1 { "type": "text", "placeholder": "package name" }

open "https://www.npmjs.com/search?q=${1// /%20}"
