#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title JS Beautify/Minify
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Beautify or minify your current clipboard as JavaScript
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://jsformatter?clipboard
