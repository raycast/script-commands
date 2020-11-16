#!/bin/bash

# Dependency: do-not-disturb-cli (https://github.com/sindresorhus/do-not-disturb-cli)
# Install via npm: `npm install --global do-not-disturb-cli`

# @raycast.schemaVersion 1
# @raycast.title Turn Off Do Not Disturb
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

if [[ $status = "off" ]]; then
	echo "DND already off"
	exit 0
fi

do-not-disturb off

status=$(do-not-disturb status)

if [[ $status = "off" ]]; then
	echo "Turned DND off"
else
	echo "Unable to turn DND off"
fi