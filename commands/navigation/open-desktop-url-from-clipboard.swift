#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Open Clipboard URL on Desktop
// @raycast.mode silent
// @raycast.packageName Navigation

// Optional parameters:
// @raycast.icon 🖥

// Documentation:
// @raycast.description Opens the URL from the clipboard in the desktop app.

import Cocoa

guard let string = NSPasteboard.general.string(forType: .string) else {
  throw CocoaError(.serviceInvalidPasteboardData)
}

guard let url = URL(string: string) else {
  throw URLError(.unsupportedURL)
}

func mapURLWithPrefix(_ prefix: String, scheme: String) -> (URL) -> URL? {
  return { url in
    guard let httpsRange = url.absoluteString.range(of: prefix) else { return nil }
    let suffix = url.absoluteString[httpsRange.upperBound...]
    return URL(string: scheme + suffix)
  }
}

let mapURLs = [
  mapURLWithPrefix("https://www.notion.so/", scheme: "notion://"),
  mapURLWithPrefix("https://linear.app/", scheme: "linear://"),
  mapURLWithPrefix("https://www.figma.com/", scheme: "figma://"),
]

guard
  let mappedURL = mapURLs.lazy.compactMap({ $0(url) }).first,
  let appURL = NSWorkspace.shared.urlForApplication(toOpen: mappedURL),
  NSWorkspace.shared.open(mappedURL)
else {
  NSWorkspace.shared.open(url)
  exit(0)
}

print("URL is open in \(appURL.deletingPathExtension().lastPathComponent)")
