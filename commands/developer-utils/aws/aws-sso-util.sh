#!/bin/bash

# Dependency: This script requires `aws-sso-util` installed: https://github.com/benkehoe/aws-sso-util
# Install via pipx: `pipx install aws-sso-util` following the instructions on https://github.com/benkehoe/aws-sso-util

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Single Sign-On
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/aws-sso-util.png
# @raycast.packageName AWS

# Documentation:
# @raycast.description Login to AWS using aws-sso-util
# @raycast.author David Molinero
# @raycast.authorURL https://github.com/doktor500

export PATH="$PATH:${HOME}/.local/bin/";

if ! aws-sso-util &> /dev/null; then
  echo "aws-sso-util is required (https://github.com/benkehoe/aws-sso-util)";
  exit 1;
fi

aws-sso-util login --all;
