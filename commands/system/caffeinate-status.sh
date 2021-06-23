#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Caffeinate
# @raycast.mode inline
# @raycast.packageName System
# @raycast.refreshTime 30s
#
# Optional parameters:
# @raycast.icon ☕️
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Shows caffeinate status
# @raycast.author Yan Smaliak
# @raycast.authorURL https://github.com/ysmaliak

caffeinate_ps=$(ps aux | grep '\d caffeinate')

if [ -z "$caffeinate_ps" ]
then
    echo "Caffeinate is not active"
else
    echo "Caffeinate is running"
fi
