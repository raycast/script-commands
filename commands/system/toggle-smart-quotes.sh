#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Smart Quotes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/quotes.png
# @raycast.packageName System

# Documentation:
# @raycast.description Toggle between "regular" quotes and auto-substituted "smart" quotes.
# @raycast.author elstgav
# @raycast.authorURL https://github.com/elstgav

set -u

menu_result="$(
  osascript <<'APPLESCRIPT'
using terms from application "System Events"
on isChecked(targetItem)
  repeat with attrName in {"AXValue", "AXValueDescription", "AXMenuItemMarkChar"}
    try
      set attrState to my stateFromAttribute(value of attribute (contents of attrName) of targetItem)
      if attrState is not missing value then return attrState
    end try
  end repeat

  try
    return selected of targetItem
  on error
    return missing value
  end try
end isChecked

on stateFromAttribute(rawValue)
  if rawValue is missing value then return missing value

  try
    if rawValue is true then return true
    if rawValue is false then return false
  end try

  try
    set intValue to rawValue as integer
    if intValue is 1 then return true
    if intValue is 0 then return false
  end try

  try
    set textValue to rawValue as text
    if textValue is "" then return missing value
    if textValue is "1" then return true
    if textValue is "0" then return false
    if textValue is "true" then return true
    if textValue is "false" then return false
    if textValue is "on" then return true
    if textValue is "off" then return false
    if textValue is "yes" then return true
    if textValue is "no" then return false
    if textValue is not "" then return true
  end try

  return missing value
end stateFromAttribute

on restoreFocus(focusedElement)
  if focusedElement is missing value then return

  try
    set value of attribute "AXFocused" of focusedElement to true
  end try
end restoreFocus

on closeMenus(frontApp, menuState)
  if menuState is "none" or menuState is "clicked-target" then return

  try
    tell frontApp to click menu bar item "Edit" of menu bar 1
    delay 0.03
  end try
end closeMenus

on findTargetItem(substitutionsMenu)
  repeat with candidateName in {"Smart Quotes", "Smart Quotes and Dashes"}
    try
      return menu item (contents of candidateName) of substitutionsMenu
    end try
  end repeat

  repeat with i from 1 to (count of menu items of substitutionsMenu)
    set currentItem to menu item i of substitutionsMenu
    try
      set itemName to name of currentItem as text
      if itemName contains "Smart Quote" or itemName contains "Smart Quotes" then
        return currentItem
      end if
    end try
  end repeat

  return missing value
end findTargetItem

tell application "System Events"
  try
    set frontApp to first application process whose frontmost is true
    set frontAppName to name of frontApp as text
    set focusedElement to missing value
    set menuState to "none"

    try
      set focusedElement to value of attribute "AXFocusedUIElement" of frontApp
    end try

    try
      tell frontApp
        set editMenuBarItem to menu bar item "Edit" of menu bar 1
        click editMenuBarItem
        set menuState to "edit-open"
        delay 0.05

        set editMenu to menu 1 of editMenuBarItem
        set substitutionsMenuItem to menu item "Substitutions" of editMenu
        if enabled of substitutionsMenuItem is false then error "focus-text-field"

        click substitutionsMenuItem
        set menuState to "substitutions-open"
        delay 0.05

        set substitutionsMenu to menu 1 of substitutionsMenuItem
        set targetItem to my findTargetItem(substitutionsMenu)
        if targetItem is missing value then error "focus-text-field"
        if enabled of targetItem is false then error "focus-text-field"
      end tell

      set wasChecked to my isChecked(targetItem)
      click targetItem
      set menuState to "clicked-target"
      delay 0.1
      my restoreFocus(focusedElement)

      if wasChecked is true then
        return "menu:" & frontAppName & ":off"
      else if wasChecked is false then
        return "menu:" & frontAppName & ":on"
      else
        error "unknown-state"
      end if

    on error errMsg number errNum
      my closeMenus(frontApp, menuState)
      my restoreFocus(focusedElement)

      if errMsg is "focus-text-field" then return "error:focus-text-field"
      if errNum is -1719 then return "error:accessibility"
      if errNum is -1743 then return "error:automation"
      if errMsg contains "Can’t get menu bar item \"Edit\"" then return "error:no-edit-menu"
      return "error:generic"
    end try

  on error errMsg number errNum
    my closeMenus(frontApp, menuState)
    my restoreFocus(focusedElement)

    if errNum is -1719 then return "error:accessibility"
    if errNum is -1743 then return "error:automation"
    if errMsg contains "Can’t get menu bar item \"Edit\"" then return "error:no-edit-menu"
    return "error:generic"
  end try
end tell
end using terms from
APPLESCRIPT
)"

case "$menu_result" in
  menu:*)
    app_name="${menu_result#menu:}"
    app_state="${app_name##*:}"
    app_name="${app_name%:*}"

    if [[ "$app_state" == "on" ]]; then
      printf '%s\n' "${app_name} Smart Quotes On"
    else
      printf '%s\n' "${app_name} Smart Quotes Off" >&2
    fi
    ;;
  error:focus-text-field)
    printf '%s\n' "Select a text field to toggle Smart Quotes" >&2
    exit 1
    ;;
  error:accessibility)
    printf '%s\n' "Allow Raycast in Accessibility" >&2
    exit 1
    ;;
  error:automation)
    printf '%s\n' "Allow Raycast in Automation" >&2
    exit 1
    ;;
  error:no-edit-menu)
    printf '%s\n' "This app doesn't expose Edit > Substitutions" >&2
    exit 1
    ;;
  *)
    printf '%s\n' "Couldn't toggle Smart Quotes" >&2
    exit 1
    ;;
esac
