#!/bin/bash

# Dependency: This script requires `docker for mac` to be installed: https://docs.docker.com/docker-for-mac/install/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title docker images
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon images/docker.png
# @raycast.packageName Developer Utilities
#
# @raycast.description Runs docker images
# @raycast.author Sebastian Kroll
# @raycase.authorURL https://github.com/skrollme

docker images
