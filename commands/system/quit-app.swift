#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Quit app
// @raycast.mode silent
// @raycast.packageName System

// Optional parameters:
// @raycast.icon 💥
// @raycast.argument1 { "type": "text", "placeholder": "Name or pid" }

// Documentation:
// @raycast.description Quits an app, by name or process id.
// @raycast.author Roland Leth
// @raycast.authorURL https://runtimesharks.com

import AppKit

let argument = Array(CommandLine.arguments.dropFirst()).first!

if let processId = Int(argument) {
	guard
		let app = NSWorkspace.shared
			.runningApplications
			.first(where: { $0.processIdentifier == processId })
	else {
		print("Couldn't find app with process id \(processId)")
		exit(1)
	}

	app.terminate()

	print("Quit \(app.localizedName ?? "\(processId)")")
} else {
	guard
		let app = NSWorkspace.shared
			.runningApplications
			.first(where: {
				$0.localizedName?.localizedCaseInsensitiveContains(argument) == true
			})
	else {
		print("Couldn't find app with name \(argument)")
		exit(1)
	}

	app.terminate()

	print("Quit \(app.localizedName ?? argument)")
}
