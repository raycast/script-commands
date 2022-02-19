#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title HTML Preview
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Show a HTML preview of your current clipboard string
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://htmlpreview?clipboard
