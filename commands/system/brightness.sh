#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Brightness
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ☀️
# @raycast.packageName System brightness
# @raycast.argument1 { "type": "text", "placeholder": "brightness", "percentEncoded": false }
#
# @Documentation:
# @raycast.description Set system brightness
# @raycast.author Antonio Dal Sie
# @raycast.authorURL https://github.com/exodusanto

./brightness $(awk '{print $1*$2}' <<<"${1} 0.01")
