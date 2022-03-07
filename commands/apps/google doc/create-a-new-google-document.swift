#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Create a new google document
// @raycast.mode silent

// Optional parameters:
// @raycast.icon ./images/google-doc.png

// Documentation:
// @raycast.author pradeepb28
// @raycast.authorURL https://twitter.com/pradeepb28

import Cocoa

if let createNewDocURL = URL(string: "https://docs.new") {
    NSWorkspace.shared.open(createNewDocURL)
}

