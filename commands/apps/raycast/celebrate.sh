#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Celebrate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎉
# @raycast.argument1 { "type": "text", "placeholder": "Times (Default: 1)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Interval (Default: 0)", "optional": true  }
# @raycast.packageName Raycast

# Documentation:
# @raycast.description Set Confetti to run for a number of times and during intervals
# @raycast.author Fatpandac
# @raycast.authorURL https://github.com/Fatpandac

times=1
interval=0

if [ -n "$1" ]; then
    times=$1
fi
if [ -n "$2" ]; then
    interval=$(($2))
fi

for i in $(seq 1 $times); do
    open raycast://confetti
    echo "Celebrate  🎉"
    sleep $interval
done
