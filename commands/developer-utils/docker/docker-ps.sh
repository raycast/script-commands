#!/bin/bash

# Dependency: This script requires `docker for mac` to be installed: https://docs.docker.com/docker-for-mac/install/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title List Containers
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon images/docker.png
# @raycast.packageName Docker
#
# @raycast.description List containers in Docker
# @raycast.author Sebastian Kroll
# @raycase.authorURL https://github.com/skrollme

if ! command -v docker &> /dev/null; then
      echo "docker for mac is required (https://docs.docker.com/docker-for-mac/install/).";
      exit 1;
fi

docker ps
