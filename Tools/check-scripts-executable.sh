#!/bin/bash

echo "Searching for and adjusting non-executable scripts"

find "./commands" -type f ! -path '*/Tools/*' ! -path '*/images/*' ! -path './commands/extensions.json' ! -path './commands/README.md' -exec bash -c 'chmod +x "$0"' {} \;

if `git status | grep -q "nothing to commit"`; then
    echo "Found scripts are executable"
    exit 0;
else
    echo "Found non-executable scripts"

    git config --local user.email "bot@raycast.com"
    git config --local user.name "Raycast Bot"
    git add -u
    git commit -m "Set scripts as executable"

    exit 0;
fi