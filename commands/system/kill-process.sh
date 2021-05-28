#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Kill Running Process
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon ⚠️
# @raycast.argument1 { "type": "text", "placeholder": "process name" }

# Documentation:
# @raycast.description Force kill a running process
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras

pkill -9 "$1"