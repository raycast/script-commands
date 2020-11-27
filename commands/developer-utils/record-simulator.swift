#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Record Simulator
// @raycast.mode compact
// @raycast.packageName Developer Utilities
//
// Optional parameters:
// @raycast.author Maxim Krouk
// @raycast.authorURL https://github.com/maximkrouk
// @raycast.description Records simulator to Downloads folder
// @raycast.needsConfirmation true
// @raycast.icon 📱
// @raycast.argument1 { "type": "text", "placeholder": "Filename" }
// @raycast.currentDirectoryPath ~/Downloads

import Foundation

@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/bin/zsh"
    task.arguments = ["-c", args.joined(separator: " ")]
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

let fullName = CommandLine.arguments[1]
    .replacingOccurrences(of: " ", with: #"\ "#)
    .appending(".mp4")

shell("xcrun", "simctl", "io", "booted", "recordVideo", fullName)
shell("open", "-R", fullName)
