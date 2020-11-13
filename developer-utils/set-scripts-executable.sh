#!/bin/bash

directories=(
)

# @raycast.schemaVersion 1
# @raycast.title Set scripts executable
# @raycast.mode compact
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Set scripts within specified directories as executable.
# @raycast.packageName Script Commands

if [ ${#directories[@]} -eq 0 ]; then
	echo "Set working directories.";
	exit 1;
fi

for dir in "${directories[@]}"; do
	find "$dir" -type f \( -iname "*.sh" -o -iname "*.swift" -o -iname "*.applescript" \) ! -path '*/Tools/*' -exec bash -c 'chmod +x "$0"' {} \;
done

echo "Script Commands executable"