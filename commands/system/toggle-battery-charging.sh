#!/bin/bash

# Note: You must do two steps for this script to work.
# 1- run "curl https://raw.githubusercontent.com/actuallymentor/battery/main/setup.sh | sudo bash" to install smc and battery script
# 2- run "battery visudo" to add battery command to sudoers

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Battery Charging
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔋
# @raycast.packageName System

# Documentation:
# @raycast.description Toggle charging the battery when it is plugged in. When turned off, it will always use the charger instead of the battery; when turned on, it will go to automatic mode (decide based on your settings and daily charging routine).
# @raycast.author Amir Hossein SamadiPour
# @raycast.authorURL https://github.com/SamadiPour

hex_status=$( smc -k CH0B -r | awk '{print $4}' | sed s:\):: )
if [[ "$hex_status" == "00" ]]; then
    battery charging off
    echo "Charging OFF"
else
    battery charging on
    echo "Charging ON"
fi
