#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Open Last Download
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 💁‍♂️

import AppKit

// MARK: - Convenience

extension URL {
  var addedToDirectoryDate: Date {
    return (try? resourceValues(forKeys: [.addedToDirectoryDateKey]).addedToDirectoryDate) ?? .distantPast
  }
}

func failure(_ message: String) -> Never {
  print(message)
  exit(1)
}

// MARK: - Main

do {
  let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!

  let downloads = try FileManager.default.contentsOfDirectory(at: downloadsDirectory, includingPropertiesForKeys: [.addedToDirectoryDateKey], options: .skipsHiddenFiles)

  guard let lastDownload = downloads.sorted(by: { $0.addedToDirectoryDate > $1.addedToDirectoryDate }).first else {
    failure("No downloaded files")
  }

  NSWorkspace.shared.open(lastDownload)
} catch {
  failure(error.localizedDescription)
}
