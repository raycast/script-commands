#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Flutter Create Project
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon images/flutter.png
# @raycast.argument1 { "type": "text", "placeholder": "ProjectName" }
# @raycast.packageName flutter-create

# Documentation:
# @raycast.description Creates A Flutter Project from Raycast
# @raycast.author Kabilan VS
# @raycast.authorURL https://github.com/KABILAN235

# Flutter SDK Path. Eg: /Users/$USER/Devtools/flutter/bin
SDK_PATH="/Users/$USER/DevTools/flutter/bin"

# Default Project Path, ie- This is Where Your Projects will be Stored
PROJECT_PATH="/Users/$USER/Desktop/Dev/FlutterProjects/"

export PATH="$PATH:$SDK_PATH"
export PATH
first_argument=${1// /+}
cd $PROJECT_PATH;
flutter create $first_argument


