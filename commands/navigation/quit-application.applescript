#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quit Application
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/quit.png
# @raycast.argument1 { "type": "text", "placeholder": "Name", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Force quit?", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Quit the application. Edit the command to change the default values (Application: "", Force quit?: "No").

on run argv
	
	### Configuration ###
	
	set defaultApp to ""
	set defaultForceQuit to false
	
	### End of configuration ###
	
	try
		set app_ to getApplication(item 1 of argv, defaultApp)
		set forceQuit to getForceQuit(item 2 of argv, defaultForceQuit)
		
		quitApplication(app_, forceQuit)
		
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

on getForceQuit(arg, defaultForceQuit)
	set forceQuit to arg
	if forceQuit = "" then
		set forceQuit to defaultForceQuit
	else if forceQuit is in {"no", "n"} then
		set forceQuit to false
	else if forceQuit is in {"yes", "y"} then
		set forceQuit to true
	else
		error "Wrong value of the \"Force quit?\" argument: use \"y(es)\" or \"n(o)\""
	end if
	return forceQuit
end getForceQuit

on quitApplication(app_, forceQuit)
	tell application app_
		if not forceQuit then
			quit
		else
			do shell script "pkill -i " & app_
		end if
	end tell
end quitApplication
