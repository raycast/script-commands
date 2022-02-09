#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Configure
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/duckduckgo_logo.png
# @raycast.argument1 { "type": "text", "placeholder": "@duck.com authorizationID" }
# @raycast.packageName DuckDuckGo Email Protection

# Documentation:
# @raycast.description Use this script command to configure your @duck.com authorizationID
# @raycast.author Rediwed
# @raycast.authorURL github.com/Rediwed

on run argv
	set prefix to do shell script "curl -X POST https://quack.duckduckgo.com/api/email/addresses --header 'Authorization: Bearer " & (item 1 of argv) & "'"
	if text 3 through 9 of prefix is "address" then
		setAuthorizationID(item 1 of argv)
	else
		tell me to error "Could not configure authorizationID. Duck.com API result: " & prefix
	end if
end run

on setAuthorizationID(authorizationID)
	try
		return do shell script "defaults write com.dpe.ddgEmailProtection AuthorizationID " & authorizationID
	on error
		tell me to error "Authorization ID not set, please run configure script command"
	end try
end setAuthorizationID


