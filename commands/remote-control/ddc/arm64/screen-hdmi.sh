#!/bin/bash

# Dependency: This script requires `m1ddc` cli installed: https://github.com/waydabber/m1ddc
# Install via github: `https://github.com/waydabber/m1ddc`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch to HDMI
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📺
# @raycast.author goodhyun
# @raycast.packageName External Display
# @raycast.description This script will switch the external display screen to HDMI.


if ! command -v m1ddc &> /dev/null; then
      echo "m1ddc command is required (https://github.com/waydabber/m1ddc).";
      exit 1;
fi

m1ddc set input 17
