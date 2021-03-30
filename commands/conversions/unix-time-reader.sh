#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Unix Time Reader
# @raycast.mode compact
# @raycast.packageName Conversions
#
# @raycast.icon 🕰
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Display Human-Readable Date from Unix Time in Pasteboard
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
	echo "Not Unix Time in Pasteboard"
	exit 1
fi

echo "$unixTime -> $readable"