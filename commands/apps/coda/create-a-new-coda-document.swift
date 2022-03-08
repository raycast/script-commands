#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Create a new coda document
// @raycast.mode silent

// Optional parameters:
// @raycast.icon ./images/coda.png

// Documentation:
// @raycast.author pradeepb28
// @raycast.authorURL https://twitter.com/pradeepb28

import Cocoa

if let createNewDocURL = URL(string: "https://coda.new") {
    NSWorkspace.shared.open(createNewDocURL)
}

