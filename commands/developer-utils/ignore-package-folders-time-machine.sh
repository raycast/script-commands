#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ignore package folders from Time Machine
# @raycast.mode inline
# @raycast.refreshTime 1d
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🧹

# Documentation:
# @raycast.description Ignore package folders (node_modules, Pods, etc) from Time Machine backups. They might not be big in size, but they usually have tens of thousands of files, making backups slower than they should be. Many files are worse than big files.
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

# Change this to your projects' folder.
# You can use `$HOME` for a relative path to your home folder,
# for example `"$HOME/web-projects"` expands to `/Users/you/web-projects`.
WORK_DIR=""

# Add or remove as needed, separated by `|`.
DIRS="node_modules|Carthage|Pods"

# -E means to use extended regex;
# -maxdepth means it'll drill into that many subfolders, starting at the folder set above,
# so if you start at `/Users/you/web-projects`, it'll go as far as
# `/Users/you/web-projects/1/2/3/4/5/6/7/node_modules`;
# -type d means to search for directories;
# -iregex means case insensitive regex;
# -prune means it'll skip matches inside matches, meaning it will skip
# `/some/path/node_modules/other/node_modules` since `/some/path/node_modules` was matched;
cmd=(find -E "$WORK_DIR" -maxdepth 8 -type d -iregex ".*\/($DIRS).*" -prune)

# Use this to first confirm they're what you want; it'll print them all.
# "${cmd[@]}"

# -exec means it passes all the output to `tmutil` and `{} \;` is just ending the statement.
"${cmd[@]}" -exec tmutil addexclusion {} \;

# Use this to confirm they're excluded:
# - `[Included]` means they will get backed up;
# - `[Excluded]` means they won't get backed up.
# "${cmd[@]}" -exec tmutil isexcluded {} \;

date "+%d %b, %I:%m %p"
