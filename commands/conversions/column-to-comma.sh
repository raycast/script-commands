#!/bin/bash

# Dependency: requires gnu-sed (also known as gsed) (https://formulae.brew.sh/formula/gnu-sed)
# Install with Homebrew: `brew install gnu-sed`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Column to Comma
# @raycast.mode silent
# @raycast.packageName Conversions

if ! command -v gsed &> /dev/null; then
	echo "gsed command is required (https://formulae.brew.sh/formula/gnu-sed).";
	exit 1;
fi

clipboard=$(pbpaste)

echo "$clipboard" | gsed ':a;N;$!ba;$s/\n/,/g' | pbcopy
