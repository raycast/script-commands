#!/bin/bash

# @raycast.title Ping
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Ping an IP address or URL.

# @raycast.icon 🌐
# @raycast.mode fullOutput
# @raycast.packageName Internet
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "URL or IP address" }

ping -i 0.25 -t 3 "$1"