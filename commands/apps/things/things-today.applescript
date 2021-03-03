#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Today
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.packageName Things
# @raycast.icon images/things.png

# Documentation:
# @raycast.description Get an overview of your completed tasks for today.
# @raycast.author Things
# @raycast.authorURL https://twitter.com/culturedcode/

if application "Things3" is not running then
	log "Things is not running"
	return
end if

tell application "Things3"
  set todayTodos to to dos of list "Today"

  set todosCount to the length of todayTodos
  set completedTodosCount to 0

  repeat with i from 1 to count of todayToDos
    set todo to item i of todayToDos

    if status of todo is completed then
      set completedTodosCount to completedTodosCount + 1
    end if 
  end repeat

  if completedTodosCount is equal to todosCount then
    log "You're all done for today 🎉"
  else
    set progress to round(100 * completedTodosCount / todosCount)
    log (progress as string) & "% Completed of " & todosCount & " To-Dos"
  end if
end tell