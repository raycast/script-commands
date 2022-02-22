#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screen HDMI
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📺
# @raycast.author goodhyun

if ! command -v m1ddc &> /dev/null; then
      echo "m1ddc command is required (https://github.com/waydabber/m1ddc).";
      exit 1;
fi

m1ddc set input 17
