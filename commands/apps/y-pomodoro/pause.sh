#!/bin/bash

# Dependency: This script requires `y-pomodoro` downloaded: https://github.com/jesse-c/y-pomodoro
# Run via: `cargo run`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pause
# @raycast.packageName y-pomodoro
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🍅
# @raycast.description Pause active pomodoro timer using  [y-pomodoro](https://github.com/jesse-c/y-pomodoro)

# Documentation:
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c


printf "pause" | nc -U /tmp/pomodoro.sock
