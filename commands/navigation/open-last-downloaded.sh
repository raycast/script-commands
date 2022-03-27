#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Last Downloaded
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/folder-home.png

# Documentation:
# @raycast.description Opens the last file that was downloaded

open ~/"Downloads/$(ls -tr ~/Downloads/ | tail -n 1)"