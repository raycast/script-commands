#!/bin/bash

# Note: You must do two steps for this script to work.
# 1- run "curl https://raw.githubusercontent.com/actuallymentor/battery/main/setup.sh | sudo bash" to install smc and battery script
# 2- run "battery visudo" to add battery command to sudoers

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle battery charging
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔋

# Documentation:
# @raycast.author Amir Hossein SamadiPour
# @raycast.authorURL https://github.com/SamadiPour

status=$(battery status | awk 'NF>1{print $NF}')
if [ "$status" = "enabled" ]; then
    battery charging off
    echo "Charging OFF"
else
    battery charging on
    echo "Charging ON"
fi
