#!/bin/bash

# Dependency: This script requires `blueutil` cli installed: https://github.com/toy/blueutil
# Install via homebrew: `brew install blueutil`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Magic Keyboard switcher
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/logo.png
# @raycast.packageName System

# Documentation:
# @raycast.author blastik
# @raycast.authorURL https://github.com/blastik
# @raycast.description Switch a single magic keyboard between computers

# blueutil location
BIN=/opt/homebrew/bin/blueutil

# Your Magic Keyboard MAC Address
BTMAC='XX:XX:XX:XX:XX:XX'

CMD_VAL="$($BIN --is-connected $BTMAC)"
CMD_UNPAIR="$BIN --unpair $BTMAC"
CMD_PAIR="$BIN --pair $BTMAC"
CMD_CONN="$BIN --connect $BTMAC"

if ! command -v blueutil &> /dev/null; then
      echo "blueutil command is required (https://github.com/toy/blueutil).";
      exit 1;
fi

if [[ "$CMD_VAL" -eq 1 ]]; then
    echo "Connected to $BTMAC"
    echo "Going to disconnect $BTMAC"
    $($CMD_UNPAIR)
    if [[ $? -eq 0 ]]; then
        echo "Disconnected from $BTMAC"
    else
        echo "Failed to disconnect from $BTMAC"
        exit 1
    fi
else
    echo "Not connected to $BTMAC"
    $($CMD_PAIR)
    sleep 1
    $($CMD_CONN)
    if [[ $? -eq 0 ]]; then
        echo "Connected to $BTMAC"
    else
        echo "Failed to connect to $BTMAC"
        exit 1
    fi
fi
