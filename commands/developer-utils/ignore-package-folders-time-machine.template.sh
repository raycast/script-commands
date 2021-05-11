#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ignore Package Folders
# @raycast.mode inline
# @raycast.refreshTime 1d
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🧹

# Documentation:
# @raycast.description Ignore package folders (node_modules, Pods, etc) from Time Machine backups. They might not be big in size (altough they do add up), but they usually have tens of thousands of files, making backups slower than they should be. Many files are worse than big files when copying. You can also add a Spotlight comment to each file, to easily be able to exclude the same folders from Spotlight indexing (disabled by default).
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

# Change this to your projects' folder.
# You can use `$HOME` for a relative path to your home folder,
# for example `"$HOME/web-projects"` expands to `/Users/you/web-projects`.
WORK_DIR=""
DEPTH=8

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
cmd=(find -E "$WORK_DIR" -maxdepth "$DEPTH" -type d -iregex ".*\/($DIRS).*" -prune)

# Use this to first confirm they're what you want; it'll print them all.
# "${cmd[@]}"

# -exec means it passes all the output to `tmutil`, `{}` is replaced by the pathname of the file, and `\+` tells it to pass all paths at once.
"${cmd[@]}" -exec tmutil addexclusion {} \+

# This adds a spotlight metadata comment, so a Smart Folder (or a custom search) can be used to find all these items. The best part is that it won't return any items that are already ignored by Spotlight.
# To create a Smart Folder (or a custom search) that returns items with this comment, use a Raw Query of `kMDItemFinderComment == "ignore_spotlight_index"`.
# "${cmd[@]}" -exec xattr -w com.apple.metadata:kMDItemFinderComment "ignore_spotlight_index" {} \+

# Use these to confirm they're excluded:

# - `[Included] <some/path>` means they will get backed up;
# - `[Excluded] <some/path>` means they won't get backed up.
# "${cmd[@]}" -exec tmutil isexcluded {} \;

# `<some/path>: ignore_spotlight_index` means it added the comment;
# `xattr: <some/path>: No such xattr...` means it didn't add the comment.
# "${cmd[@]}" -exec xattr -p com.apple.metadata:kMDItemFinderComment {} \+

date "+%d %b, %I:%m %p"
