#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Celebrate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎉
# @raycast.argument1 { "type": "text", "placeholder": "times, defualt by 1", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "interval, defualt by 0", "optional": true  }
# @raycast.packageName Celebrate

# Documentation:
# @raycast.description Set Confetti run times and intervals
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
