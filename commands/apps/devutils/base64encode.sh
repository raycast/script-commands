#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title Base64 String Encode/Decode
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Decode the Base64 string in clipboard (if it’s decodable)
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://base64encode?clipboard
