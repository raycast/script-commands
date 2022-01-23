#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title URL Parser
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Parse the URL string currently in your clipboard
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://querystringparser?clipboard
