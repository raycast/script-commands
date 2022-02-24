#!/bin/bash

# Dependency: This script requires `ddcctl` cli installed: https://github.com/kfix/ddcctl
# Install via homebrew: `brew install ddcctl`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch to HDMI
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📺
# @raycast.author goodhyun
# @raycast.packageName External Display
# @raycast.description This script will switch the external display screen to HDMI.


if ! command -v ddcctl &> /dev/null; then
      echo "ddcctl command is required (https://github.com/kfix/ddcctl).";
      exit 1;
fi

ddcctl -d 1 -i 17
