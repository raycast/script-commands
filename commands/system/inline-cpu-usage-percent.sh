#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title CPU Usage
# @raycast.mode inline
# @raycast.packageName System
# @raycast.refreshTime 10s

# Optional parameters:
# @raycast.icon 🖥️

# Documentation:
# @raycast.description Display CPU usage percent
# @raycast.author Juan Luis Romero
# @raycast.authorURL https://github.com/JuanluR8


output=$(top -l 1 | grep "CPU usage")
cpu_usage=$(echo "$output" | awk -F " " '{print $3}' | cut -d% -f1)

echo "CPU Usage: ${cpu_usage}%"