#!/usr/bin/env bash

# Dependency: requires coreutils
# Install via Homebrew: `brew install coreutils`
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Time Converter
# @raycast.mode fullOutput
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 🕰️
# @raycast.currentDirectoryPath /
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "dest_tz", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "src_tz", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "src_time", "optional": true }
#
# Documentation:
# @raycast.description Convert time into a different timezone
# @raycast.author Luigi Cardito
# @raycast.authorURL https://github.com/lcardito

set -e

SYSTEM_TZ=$(date +%Z)
SYSTEM_TIME=$(date +%H:%M)

DST_TZ=$1
SRC_TZ="${2:-${SYSTEM_TZ}}"
SRC_TIME="${3:-${SYSTEM_TIME}}"

TZ="${DST_TZ}" gdate -d "${SRC_TIME} ${SRC_TZ}" +'%H:%M %Z'
