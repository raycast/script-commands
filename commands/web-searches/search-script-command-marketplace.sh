#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Script Command
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/marketplace-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "query"}
# @raycast.packageName Web Searches
# @raycast.description Search for Script Commands in the [Unofficial Raycast Script Commands Marketplace](https://scriptcommands.com).

# Documentation:
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti

open "https://scriptcommands.com/?search=$1"

