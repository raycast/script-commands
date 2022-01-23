#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title String Inspector
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Inspect your current clipboard string (length, words count, unicode, etc.)
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://stringinspect?clipboard
