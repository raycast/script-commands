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
let runningApps = NSWorkspace.shared.runningApplications

if let processId = Int(argument) {
	runningApps
		.first { $0.processIdentifier == processId }
		.map {
			$0.terminate()

			print("Quit \($0.localizedName ?? "\(processId)")")
			exit(0)
		}

	print("No apps with process id \(processId)")
	exit(1)
}

let apps = runningApps.filter {
	$0.localizedName?.localizedCaseInsensitiveContains(argument) == true
}

if apps.isEmpty {
	print("No apps with name \(argument)")
	exit(1)
}

apps.first.map {
	// If there's just one match, quit it and exit.
	guard apps.count == 1 else { return }

	$0.terminate()

	print("Quit \($0.localizedName ?? argument)")
	exit(0)
}

runningApps
	.first { $0.localizedName?.localizedCaseInsensitiveCompare(argument) == .orderedSame }
	.map {
		// If an exact match exists, quit that and exit, even if there are several results.
		$0.terminate()

		print("Quit \($0.localizedName ?? argument)")
		exit(0)
	}

let names = apps
	.compactMap { $0.localizedName }
	.joined(separator: ", ")

if names.isEmpty {
	// Just in case `localizedName` were all `nil`, which shouldn't really happen.
	print("Multiple apps found")
} else {
	print("Multiple apps found: \(names)")
}
