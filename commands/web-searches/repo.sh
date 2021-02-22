#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open npm Package Repo
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 📦
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "package name", "percentEncoded": true }

open "http://ghub.io/${1}"
