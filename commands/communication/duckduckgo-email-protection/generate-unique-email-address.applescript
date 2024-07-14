#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Unique Address
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/duckduckgo_logo.png
# @raycast.packageName DuckDuckGo Email Protection

# Documentation:
# @raycast.description This script command generates a unique private @duck.com email address.
# @raycast.author Rediwed
# @raycast.authorURL github.com/Rediwed

on run
	set prefix to do shell script "curl -X POST https://quack.duckduckgo.com/api/email/addresses --header 'Authorization: Bearer " & getAuthorizationID() & "'"
	if text 3 through 9 of prefix is "address" then
		set uniqueAddress to text 13 through -3 of prefix & "@duck.com"
		set the clipboard to uniqueAddress
		return uniqueAddress & " copied to clipboard!"
	else
		tell me to error "An error has occured: " & prefix
	end if
end run

on getAuthorizationID()
	try
		return do shell script "defaults read com.dpe.ddgEmailProtection AuthorizationID"
	on error
		tell me to error "Authorization ID not set, please run configure script command"
	end try
end getAuthorizationID


