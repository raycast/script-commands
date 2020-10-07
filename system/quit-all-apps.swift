#!/usr/bin/swift

// NOTE: This script will only work in Raycast 0.30.0+

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Quit All Applications
// @raycast.mode silent
// Optional parameters:
// @raycast.icon 💥
// @raycast.needsConfirmation true

import AppKit

NSWorkspace.shared.runningApplications.forEach { application in
  guard application != NSRunningApplication.current, application.activationPolicy == .regular, application.bundleIdentifier != "com.apple.Finder" else { return }
  application.terminate()
}

print("Quit all applications")