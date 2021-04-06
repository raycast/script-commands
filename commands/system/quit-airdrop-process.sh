#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quit AirDrop
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🔫

# @Documentation:
# @raycast.description Quits all AirDrop processes
# @raycast.author Linus Salzmann
# @raycast.authorURL https://github.com/linus569

killall -9 'AirDrop'

