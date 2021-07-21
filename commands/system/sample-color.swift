#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Sample Color
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 🎨
//
// Documentation:
// @raycast.description Sample a color from anywhere on your screen.
// @raycast.author Jesse Claven
// @raycast.authorURL https://github.com/jesse-c

import AppKit

guard #available(OSX 10.15, *) else {
  print("macOS 10.15 or greater required")
  exit(1)
}

extension NSColor {
  var hexAlphaString: String {
    let r = lroundf(Float(redComponent) * 0xFF)
    let g = lroundf(Float(greenComponent) * 0xFF)
    let b = lroundf(Float(blueComponent) * 0xFF)
    return String(format: "#%02lX%02lX%02lX", r, g, b)
  }
}

func copyToPasteboard(_ color: String) {
  NSPasteboard.general.clearContents()
  NSPasteboard.general.writeObjects([color as NSPasteboardWriting])
}

let sampler = NSColorSampler()

sampler.show { selectedColor in
  if let selectedColor = selectedColor {
    let hexTuple = selectedColor.hexAlphaString
    copyToPasteboard(hexTuple)
    print("Sampled color: \(hexTuple)")
    exit(0)
  } else {
    print("Sampled color: none")
    exit(0)
  }
}

RunLoop.main.run()
