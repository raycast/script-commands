#!/usr/bin/swift

// NOTE: This script will only work in Raycast 0.30.0+
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Quit All Applications
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 💥
// @raycast.needsConfirmation true
//
// Documentation:
// @raycast.description Quits all running applications except Finder and Raycast.

import AppKit

let finderBundleIdentifier = "com.apple.finder"

NSWorkspace.shared.runningApplications
  .filter {
    $0 != NSRunningApplication.current
        && $0.activationPolicy == .regular
        && $0.bundleIdentifier != finderBundleIdentifier
  }
  .forEach { $0.terminate() }

print("Quit all applications")
