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
# @raycast.argument1 { "type": "text", "placeholder": "Seconds", "optional": true }

if [ -z $1 ]
then
    caffeinate -u &
    echo "Won't sleep forever" && exit 0
fi

regex='^[0-9]+$'
if ! [[ $1 =~ $regex ]] ; then
    echo "Provide a number, please" && exit 1
else
    caffeinate -u -t $1 &
    echo "Won't sleep for" $1 "seconds" && exit 0
fi
