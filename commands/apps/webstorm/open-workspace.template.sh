#!/bin/bash

# Note: WebStorm required
# Install via via JetBrains Toolbox https://www.jetbrains.com/toolbox-app/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open WebStorm
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 👨‍💻
# @raycast.packageName WebStorm
#
# Arguments
# @raycast.argument1 { "type": "text", "placeholder": "Workspace", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Close others? [yes/no]", "optional": true }
#
# Documentation:
# @raycast.description Open webstorm projects
# @raycast.author Daniel Stovv
# @raycast.authorURL https://github.com/stovv
#
# Configuration
# 1. Please make sure for webstorm installed and webstorm script available in PATH
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
  echo "Kill webstorm..."
  kill -9 "${PROCESS}"
fi

# Example:
if [[ "${WORKSPACE}" = "workspace_name" ]];then
  echo "Open ${WORKSPACE} workspace"

  # TODO: change paths to projects
  webstorm nosplash ~/Project/someProject ~/Project/someOtherProject
  echo "Workspace ${WORKSPACE} opened!"
  exit 0
fi

echo "Open webstorm projects dialog..."
webstorm nosplash dontReopenProjects
echo "Open webstorm Done!"

