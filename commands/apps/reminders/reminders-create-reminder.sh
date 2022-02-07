#!/bin/bash

# Dependency: This script requires `Quick reminder for Raycast` installed: 
https://www.icloud.com/shortcuts/62a0cedf7bce488eb0bde4b8a3a8b0de

# @raycast.title Add Reminder
# @raycast.author Andrei Nedelcu
# @raycast.authorURL https://dinosaurgame.net
# @raycast.description Add a new reminder.
#
# @raycast.icon images/reminders.png
#
# @raycast.mode silent
# @raycast.packageName Create Reminder
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "What", "percentEncoded": false}
# @raycast.argument2 { "type": "text", "placeholder": "When", "optional": true, "percentEncoded": false}

if test -z "$2"
then
	echo "${1}" | shortcuts run "Quick reminder for Raycast"
else
	echo "${1}, ${2}" | shortcuts run "Quick reminder for Raycast"
fi

echo "Reminder created!"