#!/bin/bash

# Dependency: do-not-disturb-cli (https://github.com/sindresorhus/do-not-disturb-cli)
# Install via npm: `npm install --global do-not-disturb-cli`

# @raycast.schemaVersion 1
# @raycast.title Turn On Do Not Disturb
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Uses sindresorhus/do-not-disturb-cli to turn on DND.
# @raycast.icon 😴
# @raycast.packageName System

if ! command -v do-not-disturb &> /dev/null; then
	echo "do-not-disturb-cli is required (https://github.com/sindresorhus/do-not-disturb-cli).";
	exit 1;
fi

status=$(do-not-disturb status)

if [[ $status = "on" ]]; then
	echo "DND already on"
	exit 0
fi

do-not-disturb on

status=$(do-not-disturb status)

if [[ $status = "on" ]]; then
	echo "Turned DND on"
else
	echo "Unable to turn DND on"
fi