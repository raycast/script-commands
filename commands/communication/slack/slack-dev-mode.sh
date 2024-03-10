#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch Dev Mode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/slack-logo.png
# @raycast.packageName Slack

# Documentation:
# @raycast.description Open Slack with the Developer Menu enabled. ⌘⌥I to access the Developer Menu. If you find it's not working, quit Slack and run this command again.
# @raycast.author Cody Carrell
# @raycast.authorURL https://raycast.com/sourcecody

SLACK_DEVELOPER_MENU=true open /Applications/Slack.app
