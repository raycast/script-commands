#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Unix Time Reader From Clipboard
# @raycast.mode compact
# @raycast.packageName Conversions
#
# @raycast.icon 🕰
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Display Human-Readable Date from Unix Time in Clipboard
# @raycast.author Francis Feng
# @raycast.authorURL https://github.com/francisfeng

unixTime=$(pbpaste)
size=${#unixTime}

if [[ $size == "10" ]]
then
        readable=$(echo `date -r $unixTime "+%F %T"`)
elif [[ $size == "13" ]]
then
        readable=$(echo `date -r $(($unixTime/1000)) "+%F %T"`)
else
	echo "Unix Time is not found"
	exit 1
fi

echo "$unixTime -> $readable"