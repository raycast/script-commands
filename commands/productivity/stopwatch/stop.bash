#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Stopwatch
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⏱
# @raycast.packageName time

# Documentation:
# @raycast.description Stop active stopwatch, copy total time
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

set -e

PROGRESS=$(./progress.sh)
rm timestamp_start.txt

pbcopy <<< "$FORMATTED_DIFF"

echo "FINAL TIME -> $PROGRESS"
