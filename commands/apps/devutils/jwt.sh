#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title JWT Debugger
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Decode and verify the current JWT token in your clipboard
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://jwt?clipboard
