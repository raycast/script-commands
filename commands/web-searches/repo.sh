#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open npm package repo
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 📦
# @raycast.packageName Redirect to an npm package's repository page using ghub.io
# @raycast.argument1 { "type": "text", "placeholder": "package name" }

open "http://ghub.io/${1// /%20}"
