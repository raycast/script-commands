#!/bin/bash -l

# Dependency: requires xkcdpass (https://pypi.org/project/xkcdpass/).
# Install via pip: `pip install xkcdpass`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title xkcdpass
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Use xkcdpass to create a passphrase.
# @raycast.packageName Communication
# @raycast.icon 🔐

if ! command -v xkcdpass &> /dev/null; then
	echo "xkcdpass is required (https://pypi.org/project/xkcdpass/).";
	exit 1;
fi

xkcdpass | pbcopy

echo "Copied passphrase"