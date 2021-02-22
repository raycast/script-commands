#!/usr/bin/env bash

###############################################################################
# Title: run-bash-command.sh                                                  #
#                                                                             #
# Description: run arbitrary bash command and show ouput in Raycast window.   #                                                                            #
#                                                                             #
# Usage:                                                                      #
#             > <dir> <command>                                               #
# Arguments:                                                                  #
#             <dir> the directory where your command will be excuted.         #
#                   * If blank, it uses current finder directory.             #
#         <command> Your arbitrary bash commands (oneliner).                  #
#                   * If blank, it opens the Terminal app and cd to <dir>.    #
#                                                                             #
###############################################################################
#
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run Command
# @raycast.description Run arbitrary bash command and return output in Raycast.
# @raycast.mode fullOutput
# @raycast.author Boyang Xu
# @raycast.authorURL https://github.com/BoyangMichael
#
# Optional parameters:
# @raycast.icon images/run-bash-command.png
# @raycast.packageName Bash Command
# @raycast.argument1 { "type": "text", "placeholder": "dir (blank: finder dir)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "cmd (blank: open Terminal)", "optional": true }

dir="${1/#\~/$HOME}"
cmd="$2"

# Parse directory
if [ -z "$dir" ] ; then
	finder_dir=$( osascript -e "tell application \"Finder\"" -e "set pathList to (POSIX path of (folder of the front window as alias))" -e "pathList" -e "end tell" )
	if [ -z "$finder_dir" ] ; then
		dir="${HOME}"
	else
		dir="$finder_dir"
	fi
fi

# Action
if [ -z "$cmd" ] ; then
	osascript -e "set dir to \"$dir\"" -e "dir" -e "tell application \"Terminal\"" -e "do script \"cd \" & quoted form of dir" -e "activate" -e "end tell"
else
	TERM="xterm-256color" ; export TERM
	cd "$dir"
	eval "$cmd"
	cd "$OLDPWD"
fi
