#!/bin/bash

# Dependency: requires xkcdpass (https://pypi.org/project/xkcdpass/).
# Install via pip: `pip install xkcdpass`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Passphrase
# @raycast.mode silent
# @raycast.packageName Communication

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Use xkcdpass to create a passphrase.
# @raycast.icon 🔐

if ! command -v xkcdpass &> /dev/null; then
	echo "xkcdpass is required (https://pypi.org/project/xkcdpass/).";
	exit 1;
fi

xkcdpass | pbcopy

echo "Copied passphrase"