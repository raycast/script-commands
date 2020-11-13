#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Connection Status
# @raycast.mode inline
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Check if able to access the Internet.
# @raycast.packageName Internet
# @raycast.refreshTime 1h
# @raycast.icon 🌐

if ! command -v is-online &> /dev/null; then
	echo "is-online command is required (https://github.com/sindresorhus/is-online-cli).";
	exit 1;
fi

status=$(is-online --timeout)
echo "$status"