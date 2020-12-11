#!/bin/bash

# Dependency: requires xkcdpass (https://github.com/redacted/XKCD-password-generator).
# Install via pip: `pip install xkcdpass`

# @raycast.title Generate Passphrase
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Use [xkcdpass](https://github.com/redacted/XKCD-password-generator) to create a passphrase.

# @raycast.icon 🔐
# @raycast.mode silent
# @raycast.packageName Communication
# @raycast.schemaVersion 1

if ! command -v xkcdpass &> /dev/null; then
	echo "xkcdpass is required (https://pypi.org/project/xkcdpass/).";
	exit 1;
fi

passphrase=$(xkcdpass)
echo -n $passphrase | pbcopy

echo "Copied passphrase"