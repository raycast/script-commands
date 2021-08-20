#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Foreground Mail Deeplink
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📧
# @raycast.packageName Mail

# Documentation:
# @raycast.description Copies the foreground Mail deeplink
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

tell application "System Events"
	set frontmostApp to name of application processes whose frontmost is true
end tell

# https://apple.stackexchange.com/questions/122630/applescript-comparing-variable-to-string-is-failing/122631#122631
if frontmostApp as string is equal to "Mail" then
	# https://daringfireball.net/2007/12/message_urls_leopard_mail
	tell application "Mail"
		set _sel to get selection
		set _links to {}
		repeat with _msg in _sel
			set _messageURL to "message://%3c" & _msg's message id & "%3e"
			set end of _links to _messageURL
		end repeat
		set AppleScript's text item delimiters to return
		set the clipboard to (_links as string)

		log "Copied email deeplink"
	end tell
else
	log "Foreground app was " & frontmostApp & ", not Mail"
end if
