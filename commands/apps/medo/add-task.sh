#!/bin/bash

# Note: Medo v1.0 required
# Install via Github Repo: https://github.com/Aayush9029/Medo

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Task
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/medo.png
# @raycast.argument1 { "type": "text", "placeholder": "Title" }
# @raycast.argument2 { "type": "text", "placeholder": "Priority", "default": "low","optional": true}
# @raycast.packageName Medo

# Documentation:
# @raycast.description Add a new task
# @raycast.author Aayush 
# @raycast.authorURL https://github.com/Aayush9029

open "medo://add-task?title=$1&p=$2"
