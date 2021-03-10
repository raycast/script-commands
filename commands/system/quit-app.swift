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
		print("No apps with process id \(processId)")
		exit(1)
	}

	app.terminate()

	print("Quit \(app.localizedName ?? "\(processId)")")
} else {
	let apps = NSWorkspace.shared
		.runningApplications
		.filter {
			$0.localizedName?.localizedCaseInsensitiveContains(argument) == true
		}

	guard !apps.isEmpty else {
		print("No apps with name \(argument)")
		exit(1)
	}

	guard apps.count == 1 else {
		let names = apps
			.compactMap { $0.localizedName }
			.joined(separator: ", ")

		if names.isEmpty {
			// Just in case all `localizedName` were `nil`, which shouldn't really happen.
			print("Multiple apps found")
		} else {
			print("Multiple apps found: \(names)")
		}

		exit(1)
	}

	apps.first.map {
		$0.terminate()
		print("Quit \($0.localizedName ?? argument)")
	}
}
