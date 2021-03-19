#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Close Duplicated Tabs
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Safari
# @raycast.icon images/safari.png

# @Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Close tabs with the same URL.

tell window 1 of application "Safari"
  set visitedURLs to {}
  set closedTabs to 0
  set allTabs to tabs

  repeat with i from length of allTabs to 1 by -1
    set currentTab to item i of allTabs
    set currentURL to URL of currentTab

    if visitedURLs contains currentURL then
      close currentTab
      set closedTabs to closedTabs + 1
    else 
      copy currentURL to end of visitedURLs
    end if
  end repeat

  if closedTabs is equal to 1 then
    log "Closed 1 duplicated tab"
  else if closedTabs is greater than 1 then
    log "Closed " & closedTabs & " duplicated tab"
  else 
    log "No duplicated tabs found"
  end if 
end