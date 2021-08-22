#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Project
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon images/flutter.png
# @raycast.argument1 { "type": "text", "placeholder": "Project Name" }
# @raycast.packageName Flutter

# Documentation:
# @raycast.description Creates a Flutter Project
# @raycast.author Kabilan VS
# @raycast.authorURL https://github.com/KABILAN235

# Flutter SDK Path. This Variable Points to the bin Folder in the Flutter SDK.
SDK_PATH="/Users/$USER/DevTools/flutter/bin"

# Workspace Path. Add the Path To Your Default Workspace, This Will Be The Directory Where your Projects are Created
WORKSPACE_PATH=""

export PATH="$PATH:$SDK_PATH"
first_argument=${1// /+}
cd $WORKSPACE_PATH;
flutter create $first_argument


