#!/usr/bin/env bash

###############################################################################
# Title: run-bash-command.sh                                                  #
#                                                                             #
# Description: run arbitrary bash command and show ouput in Raycast window.   #                                                                            #
#                                                                             #
# Arguments:                                                                  #
#         <command> Your arbitrary bash commands (oneliner).                  #
#                   * If blank, it opens the Terminal app and cd to <dir>.    #
#       <directory> The directory where your command will be excuted.         #
#                   * If blank, it uses current Finder directory.             #
#                     * If no open Finder window, then use $HOME.             #
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
# @raycast.argument1 { "type": "text", "placeholder": "Command (Default: open Terminal)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Directory (Default: Finder)", "optional": true }

cmd="$1"
dir="${2/#\~/$HOME}"

# Parse directory
if [ -z "$dir" ] ; then
	finder_dir=$( osascript -e "tell application \"Finder\"" -e "if exists window 1 then" -e "set pathList to (POSIX path of (folder of the front window as alias))" -e "pathList" -e "end if" -e "end tell" )
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
	TERM="linux" ; export TERM
	cd "$dir"
	eval "$cmd"
	cd "$OLDPWD"
fi
