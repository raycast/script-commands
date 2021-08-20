#!/usr/bin/osascript

# Dependencies:
# Pulse Secure: https://www.pulsesecure.net/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect / Reconnect
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Pulse Secure
# @raycast.icon images/pulse-secure.png
# @raycast.argument1 { "type": "text", "placeholder": "Connection", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Username", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Password", "optional": true, "secure": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Connect to the given / default connection with the given / default username.

on run argv
	
	### Configuration ###
	
	set defaultConnection to ""
	set defaultUsername to ""
	set keychainItemPrefix to "raycast-pulse-secure-"
	
	### End of configuration ###
	
	try
		runTray()
		
		set connection to getConnection(item 1 of argv, defaultConnection)
		set formattedConnection to formatConnection(connection)
		set keychainItem to keychainItemPrefix & formattedConnection
		set username to getUsername(item 2 of argv, defaultUsername)
		if item 3 of argv = "" then
			set pwd to getPassword(connection, username, keychainItem)
		else
			set pwd to item 3 of argv
			updatePassword(pwd, connection, username, keychainItem)
		end if
		
		disconnectOrCancel()
		connect(connection, username, pwd)
		return
		
	on error errorMessage
		closeMenu()
		return errorMessage
		
	end try
	
end run

### Functions ###

on getConnection(query, defaultConnection)
	set connection to query
	if connection = "" then
		set connection to defaultConnection
		if connection = "" then error "Default connection is not set, edit the command file"
	else if not connectionExists(query) then
		set connection to findMatchingConnection(query)
		if connection = "" then error "Connection \"" & query & "\" not found"
	end if
	return connection
end getConnection

on formatConnection(connection)
	return do shell script "python3 -c \"print('" & connection & "'.lower().replace(' ','-'))\""
end formatConnection

on getUsername(username, defaultUsername)
	if username = "" then
		set username to defaultUsername
		if username = "" then error "Default username is not set, edit the command file"
	end if
	return username
end getUsername

on getPassword(connection, username, keychainItem)
	try
		return do shell script "security find-generic-password -a '" & username & "' -s '" & keychainItem & "' -w 2> /dev/null"
	on error
		error "Keychain item \"" & keychainItem & "\" (account \"" & username & "\") not found, enter password"
	end try
end getPassword

on updatePassword(pwd, connection, username, keychainItem)
	set comment to "Credentials for Pulse Secure connection \"" & connection & "\" (username \"" & username & "\")"
	do shell script "security add-generic-password -U -a '" & username & "' -s '" & keychainItem & "' -j '" & comment & "' -w '" & pwd & "'"
end updatePassword

on connectionExists(connection)
	openMenu()
	tell application "System Events" to tell process "PulseTray"
		tell menu 1 of menu bar item 1 of menu bar 2
			return menu item connection exists
		end tell
	end tell
end connectionExists

on findMatchingConnection(query)
	openMenu()
	tell application "System Events" to tell process "PulseTray"
		tell menu 1 of menu bar item 1 of menu bar 2
			try
				return name of first menu item whose name contains query
			on error
				return ""
			end try
		end tell
	end tell
end findMatchingConnection

on disconnectOrCancel()
	openMenu()
	tell application "System Events" to tell process "PulseTray"
		tell menu 1 of menu bar item 1 of menu bar 2
			if name of menu item 3 does not contain "No active connections" then
				tell (first menu item whose value of attribute "AXMenuItemMarkChar" is " ")
					click
					tell menu 1
						if value of attribute "AXEnabled" of menu item "Disconnect" then
							click menu item "Disconnect"
						else if value of attribute "AXEnabled" of menu item "Cancel" then
							click menu item "Cancel"
						else
							error "Neither menu item \"Disconnect\" nor \"Cancel\" is active"
						end if
					end tell
				end tell
			end if
		end tell
	end tell
end disconnectOrCancel

on connect(connection, username, pwd)
	openMenu()
	tell application "System Events" to tell process "PulseTray"
		tell menu 1 of menu bar item 1 of menu bar 2 to tell menu item connection
			click
			tell menu 1
				if value of attribute "AXEnabled" of menu item "Connect" then
					click menu item "Connect"
					my waitForWindow(connection)
					keystroke username
					key code 48
					keystroke pwd
					key code 36
				else
					error "Menu item \"Connect\" is not active"
				end if
			end tell
		end tell
	end tell
end connect

on trayIsRunning()
	return application "PulseTray" is running
end trayIsRunning

on runTray()
	if not trayIsRunning() then do shell script "open -a 'PulseTray'"
end runTray

on menuIsOpen()
	tell application "System Events" to tell process "PulseTray"
		return menu 1 of menu bar item 1 of menu bar 2 exists
	end tell
end menuIsOpen

on openMenu()
	set killDelay to 0
	repeat
		tell application "System Events" to tell process "PulseTray"
			if my menuIsOpen() then return
			ignoring application responses
				click menu bar item 1 of menu bar 2
			end ignoring
		end tell
		set killDelay to killDelay + 0.1
		delay killDelay
		do shell script "killall System\\ Events"
	end repeat
end openMenu

on closeMenu()
	if menuIsOpen() then tell application "System Events" to key code 53
end closeMenu

on waitForWindow(connection)
	tell application "System Events" to tell process "PulseTray"
		repeat
			if window connection exists then
				set frontmost to true
				perform action "AXRaise" of window connection
				return
			else
				delay 0.5
			end if
		end repeat
	end tell
end waitForWindow
