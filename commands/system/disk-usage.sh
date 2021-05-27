#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disk Usage
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 💿
# @raycast.packageName System

# Documentation:
# @raycast.description Show disk usage for / (root)
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

# Example:
#
# Filesystem       Size   Used  Avail Capacity iused      ifree %iused  Mounted on
# /dev/disk1s6s1  113Gi   15Gi  3.4Gi    82%  563983 1182278497    0%   /

x=$(df -h / | awk 'FNR == 2 {printf "Root: %s available of %s",$4,$2;}')

echo "$x"

