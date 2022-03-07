#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Create a new google sheet
// @raycast.mode silent

// Optional parameters:
// @raycast.icon ./images/google-sheet.png

// Documentation:
// @raycast.author pradeepb28
// @raycast.authorURL https://twitter.com/pradeepb28

import Cocoa

if let createNewSheetURL = URL(string: "https://sheets.new") {
    NSWorkspace.shared.open(createNewSheetURL)
}

