#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screen DP
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📺
# @raycast.author goodhyun

if ! command -v ddcctl &> /dev/null; then
      echo "ddcctl command is required (https://github.com/kfix/ddcctl).";
      exit 1;
fi

ddcctl -d 1 -i 15
