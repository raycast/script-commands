#!/bin/bash

# Note: CleanShot X v3.5.1 required
# Install from https://cleanshot.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restore Recently Closed File
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/restore.png
# @raycast.packageName CleanShot X

# Documentation:
# @raycast.author CleanShot X
# @raycast.authorURL https://twitter.com/CleanShot_app
# @raycast.description Restore the recently closed file.

open "cleanshot://restore-recently-closed"
