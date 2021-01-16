#!/usr/bin/osascript

# Dependency: This script requires Pixelmator Pro to be installed: https://www.pixelmator.com/pro/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Image From Clipboard
# @raycast.mode silent
# @raycast.packageName Pixelmator Pro

# Optional parameters:
# @raycast.icon ./images/pixelmator-pro-2.0.png
# @raycast.author Bryce Carr
# @raycast.authorURL https://github.com/bdcarr

# Documentation:
# @raycast.description Creates a new document in Pixelmator Pro from the image stored in your clipboard.

activate application "Pixelmator Pro"
tell application "Pixelmator Pro" to make document from clipboard
return
