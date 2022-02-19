#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title Markdown Preview
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Preview the markdown string currently in your clipboard
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://markdownpreview?clipboard
