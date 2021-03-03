#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Current To-Do
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.packageName Things
# @raycast.icon images/things.png

# Documentation:
# @raycast.description Show your current To-Do to stay focused.
# @raycast.author Things
# @raycast.authorURL https://twitter.com/culturedcode/

if application "Things3" is not running then
	log "Things is not running"
	return
end if

tell application "Things3"
  set todayTodos to to dos of list "Today"
  
  repeat with i from 1 to count of todayToDos
    set todo to item i of todayToDos

    if status of todo is open then
      set currentTodoName to name of todo as text
      log currentTodoName
      return
    end if
  end repeat

  log "You're all done for today 🎉"
end tell