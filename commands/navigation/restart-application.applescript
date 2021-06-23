#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Application
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/restart.png
# @raycast.argument1 { "type": "text", "placeholder": "Name", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Force restart?", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Restart the application. Edit the command to change the default values (Application: "", Force restart?: "No").

on run argv
	
	### Configuration ###
	
	set defaultApp to ""
	set defaultForceRestart to false
	
	### End of configuration ###
	
	try
		set app_ to getApplication(item 1 of argv, defaultApp)
		set forceRestart to getForceRestart(item 2 of argv, defaultForceRestart)
		
		restartApplication(app_, forceRestart)
		
	on error errorMessage
		return errorMessage
		
	end try

end run

### Functions ###

on getApplication(query, defaultApp)
	set app_ to query
	if app_ = "" then
		set app_ to defaultApp
		if app_ = "" then error "Default application is not set, edit the command file"
	else if not applicationExists(query) then
		set app_ to findMatchingApplication(query)
		if app_ = "" then error "No application matching \"" & query & "\" is running"
	end if
	return app_
end getApplication

on applicationExists(app_)
	tell application "System Events"
		return (first process whose name = app_) exists
	end tell
end applicationExists

on findMatchingApplication(query)
	tell application "System Events"
		try
			return name of first process whose name contains query
		on error
			return ""
		end try
	end tell
end findMatchingApplication

on getForceRestart(arg, defaultForceRestart)
	set forceRestart to arg
	if forceRestart = "" then
		set forceRestart to defaultForceRestart
	else if forceRestart is in {"no", "n"} then
		set forceRestart to false
	else if forceRestart is in {"yes", "y"} then
		set forceRestart to true
	else
		error "Wrong value of the \"Force restart?\" argument: use \"y(es)\" or \"n(o)\""
	end if
	return forceRestart
end getForceRestart

on restartApplication(app_, forceRestart)
	tell application app_
		if not forceRestart then
			quit
		else
			do shell script "pkill -i " & app_
		end if
		
		repeat
			if not it is running then
				exit repeat
			else
				delay 0.1
			end if
		end repeat
		
		activate
	end tell
end restartApplication
