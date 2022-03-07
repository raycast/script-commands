#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Create a new google form
// @raycast.mode silent

// Optional parameters:
// @raycast.icon ./images/google-form.png

// Documentation:
// @raycast.author pradeepb28
// @raycast.authorURL https://twitter.com/pradeepb28

import Cocoa

if let createNewFormURL = URL(string: "https://forms.new") {
    NSWorkspace.shared.open(createNewFormURL)
}


