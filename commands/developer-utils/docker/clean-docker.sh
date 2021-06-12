#!/bin/bash

# Dependency: This script requires `docker for mac` to be installed: https://docs.docker.com/docker-for-mac/install/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean
# @raycast.mode compact
# @raycast.packageName Docker

# Optional parameters:
# @raycast.icon 🧹
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Script that cleans Docker images, volumes, and containers
# @raycast.author Quentin Eude
# @raycase.authorURL https://github.com/qeude

if ! command -v docker &> /dev/null; then
      echo "docker for mac is required (https://docs.docker.com/docker-for-mac/install/).";
      exit 1;
fi

docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
docker image prune -a -f
docker system prune --volumes -f
docker system -df
echo "Successfully cleaned Docker ✨"
