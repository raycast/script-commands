#!/bin/bash

# IP address or URL
target="google.com"

# @raycast.schemaVersion 1
# @raycast.title Is Up
# @raycast.mode inline
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Check if specified website is up.
# @raycast.packageName Internet
# @raycast.refreshTime 10m
# @raycast.icon 🌐

if ! command -v is-up &> /dev/null; then
	echo "is-up command is required (https://github.com/sindresorhus/is-up-cli).";
	exit 1;
fi

status=$(is-up "$target")

echo "${target}   $status"