#!/bin/bash

# How to use this script?
#
# It's a template which needs further setup. Duplicate the file, 
# remove `.template.` from the filename and set the absolute path to the folder of your Raycast script.
# Optionally, adjust the raycast.title and raycast.icon according to your needs.
# You may need to install coreutils via homebrew to use the generated scripts (gdate function).
#
# Homebrew: https://brew.sh/
# Coreutils: https://formulae.brew.sh/formula/coreutils

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Countdown
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⏱
# @raycast.argument1 { "type": "text", "placeholder": "Event Name", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Date (yyyy-mm-dd)", "percentEncoded": true }

# Documentation:
# @raycast.author Valentin Chrétien
# @raycast.authorURL https://github.com/valentinchrt
# @raycast.description Create countdowns via Raycast.

# Configuration
# 1. Specify the absolute path to the folder of your Raycast script in the DIRECTORY_SCRIPT_PATH variable below
# 2. Adjust title, icon and wording if you want to
# 3. Write the message you want to display when the countdown is at 0 ("Your message!" line 59)

DIRECTORY_SCRIPT_PATH="<your raycast script command folder path>"
RAYCAST="@raycast"

SCRIPT="#!/bin/bash\n\
\n\
# Required parameters:\n\
# $RAYCAST.schemaVersion 1\n\
# $RAYCAST.title ${1} Countdown\n\
# $RAYCAST.mode inline\n\
\n\
# Optional parameters:\n\
# $RAYCAST.icon ⏱\n\
# $RAYCAST.description See how many days/hours until ${1}.\n\
# $RAYCAST.refreshTime 10m\n\
\n\
TIMESTAMP_TODAY=\`gdate +%s\`\n\
TIMESTAMP_EVENT=\`gdate  -d \"${2}T00:00:00+00:00\" +%s\`\n\
\n\
REMAINING=\$((\$TIMESTAMP_EVENT - \$TIMESTAMP_TODAY))\n\
\n\
DAYS_REMAINING=\$((\$REMAINING / 86400))\n\
HOURS_REMAINING=\$((\$REMAINING % 86400 / 3600))\n\
\n\
if [[ \$DAYS_REMAINING > 0 || \$HOURS_REMAINING > 0 ]]; then\n\
    echo \"There are \$DAYS_REMAINING days and \$HOURS_REMAINING hours left until ${1}.\"\n\
else\n\
    echo \"Your message\!\"\n\
fi"

echo -e $SCRIPT > "$DIRECTORY_SCRIPT_PATH/countdown-${1}.sh"

chmod +x "$DIRECTORY_SCRIPT_PATH/countdown-${1}.sh"

echo Countdown created! ✅
