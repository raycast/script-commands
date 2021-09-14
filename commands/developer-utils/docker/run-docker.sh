#!/bin/bash

# Dependency: This script requires `docker for mac` to be installed: https://docs.docker.com/docker-for-mac/install/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run
# @raycast.mode compact
# @raycast.packageName Docker

# Optional parameters:
# @raycast.icon 🏃
# @raycast.needsConfirmation true
# @raycast.argument1 { "type": "text", "placeholder": "port machine" }
# @raycast.argument2 { "type": "text", "placeholder": "port docker" }
# @raycast.argument3 { "type": "text", "placeholder": "image" }

# Documentation:
# @raycast.description Script that run Docker containers
# @raycast.author Fabián Delgado
# @raycase.authorURL https://github.com/fabdelgado

if ! command -v docker &> /dev/null; then
      echo "docker for mac is required (https://docs.docker.com/docker-for-mac/install/).";
      exit 1;
fi

if ! [[ "$(docker image inspect ${3// /%20} 2> /dev/null)" == "" ]]; then
    docker pull ${3// /%20}
fi

docker run -d --rm -p $(($1)):$(($2)) ${3// /%20}

echo "Successfully created ${3}🚀"