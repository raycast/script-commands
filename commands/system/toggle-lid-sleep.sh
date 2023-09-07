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

# Note: this will not prevent laptop sleep from timeout.
# Refer to System Settings and search for 'sleep' there for
# things like 'Turn display off on battery when inactive' and
# 'Prevent automatic sleeping on power adapter when the display is off'

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Lid Sleep
# @raycast.mode inline

# Optional parameters:
# @raycast.icon 🐚
# @raycast.packageName System

# Documentation:
# @raycast.description Prevent sleep from closing laptop lid (clamshell mode)
# @raycast.author Ivan Rybalko
# @raycast.authorURL https://github.com/ivribalko

validate_exit_code()
{
    if [ $? -ne 0 ]; then
        echo "probably missing sudoers, see sources for how-to."
        exit 1
    fi
}

if [[ $(pmset -g | grep SleepDisabled | cut -f3) -eq '1' ]]; then
    sudo pmset disablesleep 0 2> /dev/null
    validate_exit_code
    echo now on 💤
else
    sudo pmset disablesleep 1 2> /dev/null
    validate_exit_code
    echo now off ☕
fi
