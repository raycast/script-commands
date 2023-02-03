#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Headphones Battery Level
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎧
# @raycast.packageName Audio

# Documentation:
# @raycast.description Get the battery level of your bluetooth headphones
# @raycast.author Mortada Sarheed
# @raycast.authorURL https://github.com/mSarheed

# Find the mac address of your headhpones by holding down option-key (⌥) (+ click on your bluetooth icon in the menubar or control centre. 
# The mac address for your headphones should look something like this A1-23-45-B6-C7, change the dashes(-) to colons (:), so A1:23:45:B6:C7
macAddr="XX:XX:XX:XX:XX"

call="system_profiler SPBluetoothDataType"

# Finds the name of the Headphones
headphonesName=$($call | grep -B1 "$macAddr" | head -n 1 | sed 's/.$//')

batteryLevel=$($call | grep -A4 "$macAddr" | grep 'Battery Level:' | grep -Eo '[0-9]{1,4}')


if [ "$batteryLevel" != "" ]; then
echo '🔋'$headphonesName' is at '$batteryLevel'% 🔋'
else
echo "🎧 Headphones aren't connected 🤷🏻‍♂️"
fi
