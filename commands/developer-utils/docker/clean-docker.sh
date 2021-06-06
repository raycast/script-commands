#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean Docker
# @raycast.mode compact
# @raycast.packageName Docker

# Optional parameters:
# @raycast.icon 🧹
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Script that cleans Docker images, volumes, and containers

docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
docker image prune -a -f
docker system prune --volumes -f
docker system -df
echo "Successfully cleaned Docker ✨"
