#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title JSON Format/Validate
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Format the JSON string currently in your clipboard (if it’s a valid JSON)
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://jsonformatter?clipboard
