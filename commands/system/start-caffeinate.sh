#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.title Caffeinate Start
# @raycast.mode silent
# @raycast.author Maxim Krouk
#
# @raycast.authorURL https://github.com/maximkrouk
# @raycast.description Prevents your device from sleepping
# @raycast.icon ☕️
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "Seconds" }

value=$1
regex='^[0-9]+$'
if ! [[ $value =~ $regex ]] ; then
  echo "Provide a number, please  ❌"
else
  caffeinate -u -t $1 '&'
  echo "Won't sleep for" $value "seconds"
fi

