#!/bin/bash

# Dependency: This script requires `iPerf` to be installed: https://iperf.fr/iperf-download.php
# Install via homebrew: `brew install iperf`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Speed Test
# @raycast.mode inline
# @raycast.refreshTime 1h
# @raycast.packageName iPerf

# Optional parameters:
# @raycast.icon 💾

# Documentation:
# @raycast.description Runs an iPerf Speed Test.
# @raycast.author Sam Wright
# @raycast.authorURL https://raycast.com/samywamy10

# Add the IP address of your iPerf server here
ip_address='192.168.86.44'

if ! command -v iperf &> /dev/null; then
    echo "iperf command is required ('brew install iperf' or https://iperf.fr/iperf-download.php).";
    exit 1;
fi

{ iperf3 -c $ip_address | grep 'sender' | tail -n 1 | awk '{print $7 " " $8}' && date +'%-I:%M%p'; } | tr '\n' ' ' | awk '{$3="@ "$3; print $0}'

