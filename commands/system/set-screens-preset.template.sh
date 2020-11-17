#!/bin/bash

# Dependency: requires displayplacer (https://github.com/jakehilborn/displayplacer)
# Install via Homebrew: `brew tap jakehilborn/jakehilborn && brew install displayplacer`

##################################################################
## Get display ID and settings by running `displayplacer list`, ##
## find the command, and copy command to `settings` variable.   ##
##                                                              ##
## See https://github.com/jakehilborn/displayplacer for help.   ##
##################################################################

# Display ID and settings
settings=""

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Screens Preset
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Apply preset screen settings.
# @raycast.icon 🖥️

if ! command -v displayplacer &> /dev/null; then
	echo "displayplacer command is required (https://github.com/jakehilborn/displayplacer).";
	exit 1;
fi

displayplacer "$settings"
displayplacer "$settings" # Running twice is necessary to restore scaling preference.

echo "Applied display preset"