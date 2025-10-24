#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Kill a process on PORT
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🚫
# @raycast.argument1 { "type": "text", "placeholder": "Ports (e.g. 3000 5000)" }

# Documentation:
# @raycast.description Kill running processes on the given ports
# @raycast.author aaqifshafi
# @raycast.authorURL https://github.com/aaqifshafi

if [ $# -eq 0 ]; then
  echo "Provide at least one port number."
  exit 1
fi

for port in "$@"
do
  pid=$(lsof -ti tcp:$port)
  if [ -n "$pid" ]; then
    kill -9 $pid
    echo "Killed process $pid on port $port"
  else
    echo "No process found on port $port"
  fi
done
