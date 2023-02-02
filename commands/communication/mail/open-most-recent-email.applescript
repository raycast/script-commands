#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Most Recent Email
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ✉️
# @raycast.packageName Mail

# Documentation:
# @raycast.description Open the last received email in your inbox in Mail.app
# @raycast.author Ben Yoon
# @raycast.authorURL https://github.com/benyn

tell application "Mail"
  if not (first message of inbox exists) then
    # Trigger a check for new email just in case.
    check for new mail
    log "No emails found in your inbox. Checking for new email."
    return
  end if

  # Get the first email from each account inbox and find the one that was received last.
  # `first message of inbox` is inadequate since it refers to
  # the first message of the first account inbox.
  set lastReceivedMessage to missing value
  repeat with accountInbox in mailboxes of inbox
    if first message of accountInbox exists then
      set firstMessage to first message of accountInbox
      if lastReceivedMessage is missing value then
        set lastReceivedMessage to firstMessage
      else if (date received of lastReceivedMessage) < (date received of firstMessage) then
        set lastReceivedMessage to firstMessage
      end if
    end if
  end repeat
  open lastReceivedMessage
  # Show nothing at the end (prevent "missing value" from being shown).
  log ""
end tell
