#!/bin/bash

# Dependency: do-not-disturb-cli (https://github.com/sindresorhus/do-not-disturb-cli)
# Install via npm: `npm install --global do-not-disturb-cli`

## Contributions welcome for a reliable, dependency-free version.

# @raycast.title Turn On Do Not Disturb
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Turn on "do not disturb" mode. Does [not work on Big Sur](https://github.com/sindresorhus/do-not-disturb-cli/issues/2).

# @raycast.icon 😴
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

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