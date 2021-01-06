#!/bin/bash

# How to use this script?
#
# It's a template which needs further setup. Duplicate the file, 
# remove `.template.` from the filename and set the date you want.
# Optionally, adjust the raycast.title and raycast.icon according to your needs.
# You may need to install coreutils via homebrew to make this script work (gdate function).
#
# Homebrew: https://brew.sh/
# Coreutils: https://formulae.brew.sh/formula/coreutils

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Countdown to Date
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 10m

# Optional parameters:
# @raycast.icon ⏱

# Documentation:
# @raycast.author Valentin Chrétien
# @raycast.authorURL https://github.com/valentinchrt
# @raycast.description See how many days/hours until a specific date.

# Configuration

# 1. Set the date you want by replacing yyyy-mm-dd in TIMESTAMP_EVENT (e.g. 2022-12-31)
# 2. Optionaly, you can set the time by editing T00:00:00+00:00
# 3. Write the message you want to display when the countdown is at 0 ("Your message!" line 46)

TIMESTAMP_EVENT=`gdate -d "yyyy-mm-ddT00:00:00+00:00" +%s`
TIMESTAMP_TODAY=`gdate +%s`

REMAINING=$(($TIMESTAMP_EVENT - $TIMESTAMP_TODAY))

DAYS_REMAINING=$(($REMAINING / 86400))
HOURS_REMAINING=$(($REMAINING % 86400 / 3600))

if [[ $DAYS_REMAINING > 0 || $HOURS_REMAINING > 0 ]]; then
    echo "There are $DAYS_REMAINING days and $HOURS_REMAINING hours left until your event."
else
    echo "Your message\!"
fi
