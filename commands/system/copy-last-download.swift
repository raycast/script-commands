#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Copy Last Download
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 💁
//
// Documentation:
// @raycast.description Copy the last downloaded file to the clipboard.

import AppKit

// MARK: - Main

guard let download = getLatestDownload() else {
  print("No recent downloads")
  exit(1)
}

copyToPasteboard(download)
print("Copied \(download.lastPathComponent)")

// MARK: - Convenience

func getLatestDownload() -> URL? {
  guard let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first else { return nil }
  return try? FileManager.default
    .contentsOfDirectory(at: downloadsDirectory, includingPropertiesForKeys: [.addedToDirectoryDateKey], options: .skipsHiddenFiles)
    .sorted { $0.addedToDirectoryDate > $1.addedToDirectoryDate }
    .first
}

func copyToPasteboard(_ url: URL) {
  NSPasteboard.general.clearContents()
  NSPasteboard.general.writeObjects([url as NSPasteboardWriting])
}

extension URL {
  var addedToDirectoryDate: Date {
    return (try? resourceValues(forKeys: [.addedToDirectoryDateKey]).addedToDirectoryDate) ?? .distantPast
  }
}