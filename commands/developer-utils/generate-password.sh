#!/bin/bash

# Dependency: requires gpg (https://www.gnupg.org/)
# Download: https://www.gnupg.org/download/#sec-1-1

# @raycast.schemaVersion 1
# @raycast.title Generate Password
# @raycast.mode silent
# @raycast.author Sven Hofmann
# @raycast.authorURL https://github.com/hofmannsven
# @raycast.description Generates a random password and copies it to the clipboard.
# @raycast.packageName Developer Utilities
# @raycast.icon 🔐

if ! command -v gpg &> /dev/null; then
	echo "gpg command is required (https://www.gnupg.org/).";
	exit 1;
fi

gpg --gen-random -a 0 30 | pbcopy
echo "Password Generated"
