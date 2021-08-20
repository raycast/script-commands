#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Stopwatch
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⏱
# @raycast.packageName stopwatch

# Documentation:
# @raycast.description Stop active stopwatch, copy total time
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

set -e

PROGRESS=$(./stopwatch-progress.sh)
rm "$TMPDIR/raycast-stopwatch-start.txt"

pbcopy <<< "$PROGRESS"

echo "FINAL TIME -> $PROGRESS"
