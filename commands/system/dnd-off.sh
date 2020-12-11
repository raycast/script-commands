#!/bin/bash

# Dependency: do-not-disturb-cli (https://github.com/sindresorhus/do-not-disturb-cli)
# Install via npm: `npm install --global do-not-disturb-cli`

## Contributions welcome for a reliable, dependency-free version.

# @raycast.title Turn Off Do Not Disturb
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Turn off "do not disturb" mode. Does [not work on Big Sur](https://github.com/sindresorhus/do-not-disturb-cli/issues/2).

# @raycast.icon 😴
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

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