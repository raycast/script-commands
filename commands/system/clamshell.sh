#!/bin/bash

# Note: You must add pmset to sudoers for this script to work.
# 1- run to create file and open editor:
# sudo visudo -f /etc/sudoers.d/pmset
# 2- press 'i' to enter input mode
# 3- paste this line into the editor:
# ALL ALL=NOPASSWD: /usr/bin/pmset
# 4- press 'esc' to exit input mode
# 5- type this to exit and save file:
# :wq

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clamshell
# @raycast.mode inline

# Optional parameters:
# @raycast.icon 🐚
# @raycast.packageName Personal

# Documentation:
# @raycast.description Toggle sleep when laptop lid's closed
# @raycast.author Ivan Rybalko
# @raycast.authorURL https://github.com/ivribalko

sudo -l | grep -wq /usr/bin/pmset

if [[ $? -eq 1 ]]; then
    echo "pmset is not in sudoers, see command's code for instructions."
    exit 1
fi

if [[ $(pmset -g | grep SleepDisabled | cut -f3) -eq '1' ]]; then
    sudo pmset disablesleep 0
    echo off 💤
else
    sudo pmset disablesleep 1
    echo on ☕
fi
