#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Ping
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Ping an IP address or URL.
# @raycast.packageName Internet
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "URL or IP address" }

ping -i 0.25 -t 3 "$1"