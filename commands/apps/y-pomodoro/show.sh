#!/bin/bash

# Dependency: This script requires `y-pomodoro` downloaded: https://github.com/jesse-c/y-pomodoro
# Run via: `cargo run`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show
# @raycast.packageName y-pomodoro
# @raycast.mode inline
# @raycast.refreshTime 15s

# Optional parameters:
# @raycast.icon 🍅
# @raycast.description Show active pomodoro timer using [y-pomodoro](https://github.com/jesse-c/y-pomodoro)

# Documentation:
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

printf "show" | nc -U /tmp/pomodoro.sock
