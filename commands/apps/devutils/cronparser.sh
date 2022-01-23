#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title Cron Job Parser
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Parse the cron job expression in clipboard (if it’s a valid cron expression)
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://cronparser?clipboard
