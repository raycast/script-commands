#!/bin/bash

# Note: WebStorm required
# Install via via JetBrains Toolbox https://www.jetbrains.com/toolbox-app/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon images/webstorm.png
# @raycast.packageName WebStorm
#
# Arguments
# @raycast.argument1 { "type": "text", "placeholder": "Workspace", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Close Others? [yes/no]", "optional": true }
#
# Documentation:
# @raycast.description Open WebStorm projects
# @raycast.author Daniel Stovv
# @raycast.authorURL https://github.com/stovv
#
# Configuration
# 1. Please make sure for WebStorm installed and WebStorm CLI available in $PATH
#    https://www.jetbrains.com/help/webstorm/working-with-the-ide-features-from-command-line.html#standalone
# 2. Configure always open projects in new window Preferences -> Appearance & Behavior -> System Settings -> Project -> Open project in [ Select: New Window ]
# 3. Add more workspaces by example

if ! command -v webstorm &> /dev/null; then
      echo "WebStorm CLI is required (https://www.jetbrains.com/help/webstorm/working-with-the-ide-features-from-command-line.html#standalone).";
      exit 1;
fi

# Main program

# Arguments
WORKSPACE=$1
CLOSE_OTHER=$2

PROCESS=$(pgrep -f webstorm)
if [ "${CLOSE_OTHER}" = "yes" ] && [ "${PROCESS}" != "" ] ;then
  echo "Kill WebStorm..."
  kill -9 "${PROCESS}"
fi

# Example:
if [[ "${WORKSPACE}" = "workspace_name" ]];then
  # TODO: change paths to projects
  webstorm nosplash ~/Project/someProject ~/Project/someOtherProject
  echo "Workspace ${WORKSPACE} opened!"
  exit 0
fi

webstorm nosplash dontReopenProjects
echo "WebStorm projects dialog opened!"