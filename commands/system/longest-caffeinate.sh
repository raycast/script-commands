#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.title Caffeinate
# @raycast.mode inline
# @raycast.author Maxim Krouk
#
# @raycast.authorURL https://github.com/maximkrouk
# @raycast.description Displays active caffeinates.
# @raycast.icon ☕️
# @raycast.packageName System
# @raycast.refreshTime 15s

search=$(ps aux | grep '\d caffeinate')

if [ -z $search ]
then
    echo "Caffeinate is not active" && exit 0
fi

caffeinates=$(echo $search \
| awk '$14=($14=="")?"x":$14, $15=($14=="x")?99999999:$14 {print $9 " " $14 " " $15}' \
| sort -k15n \
| awk '$2=($2=="x")?"forever":$2"s" {print "Start: " $1 ", Duration: " $2}' \
)

echo $caffeinates | head -n 1
