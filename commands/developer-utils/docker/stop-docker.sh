#!/bin/bash

# Dependency: This script requires `docker for mac` to be installed: https://docs.docker.com/docker-for-mac/install/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop
# @raycast.mode compact
# @raycast.packageName Docker

# Optional parameters:
# @raycast.icon ⏹️
# @raycast.needsConfirmation true
# @raycast.argument1 { "type": "text", "placeholder": "Image", "percentEncoded": true}

# Documentation:
# @raycast.description Stops a Docker container
# @raycast.author Fabián Delgado
# @raycase.authorURL https://github.com/fabdelgado

if ! command -v docker &> /dev/null; then
      echo "docker for mac is required (https://docs.docker.com/docker-for-mac/install/).";
      exit 1;
fi

docker stop $1

echo "Successfully stopped $1 ⏹️"