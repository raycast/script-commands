#!/bin/bash

###########################################
## Set website URL in "target" variable. ##
###########################################

# Website URL
target=""

# @raycast.schemaVersion 1
# @raycast.title Is Website Up
# @raycast.mode inline
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Check and monitor if specified website is up.
# @raycast.packageName Internet
# @raycast.refreshTime 10m
# @raycast.icon 🌐

if ! command -v is-up &> /dev/null; then
	echo "is-up command is required (https://github.com/sindresorhus/is-up-cli).";
	exit 1;
fi

if [ -z ${target+x} ]; then
	echo "Target is undefined.";
	exit 0
fi

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $target =~ $regex ]]; then
	status=$(is-up "$target")
	echo "${target}   $status"
else
	echo "$target is not a valid URL"
fi