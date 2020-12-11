#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Copy Last Screenshot
// @raycast.mode silent
// @raycast.packageName System

// Optional parameters:
// @raycast.icon 📸

// Documentation:
// @raycast.description Copies the last screenshot to the clipboard.

import Cocoa

// MARK: - Main

let query = NSMetadataQuery()
guard let lastScreenshot = query.searchScreenshots()?.first, let path = lastScreenshot.value(forAttribute: "kMDItemPath") as? String else {
  print("Cannot find screenshot")
  exit(1)
}

let fileURL = URL(fileURLWithPath: path)
NSPasteboard.general.clearContents()
NSPasteboard.general.writeObjects([fileURL as NSPasteboardWriting])

print("Copied last screenshot")

// MARK: - Convenience

extension NSMetadataQuery {
  func searchScreenshots() -> [NSMetadataItem]? {
    predicate = NSPredicate(format: "kMDItemIsScreenCapture = 1")
    sortDescriptors = [NSSortDescriptor(key: "kMDItemFSCreationDate", ascending: false)]

    NotificationCenter.default.addObserver(forName: .NSMetadataQueryDidFinishGathering, object: nil, queue: nil) { [weak self] _ in
      self?.disableUpdates()
      self?.stop()
      CFRunLoopStop(CFRunLoopGetCurrent());
    }

    guard start() else { return nil }

    CFRunLoopRun()

    return results.compactMap { $0 as? NSMetadataItem }
  }
}

