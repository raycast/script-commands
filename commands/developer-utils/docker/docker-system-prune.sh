#!/bin/bash

# Dependency: This script requires `docker for mac` to be installed: https://docs.docker.com/docker-for-mac/install/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title System Prune
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon images/docker.png
# @raycast.packageName Docker
#
# @raycast.description Remove unused data (system prune)
# @raycast.author Sebastian Kroll
# @raycase.authorURL https://github.com/skrollme

if ! command -v docker &> /dev/null; then
      echo "docker for mac is required (https://docs.docker.com/docker-for-mac/install/).";
      exit 1;
fi

docker system prune -f
