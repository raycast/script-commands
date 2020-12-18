#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Sample Colour
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 🎨
//
// Documentation:
// @raycast.description Sample a colour from anywhere on your screen.
// @raycast.author Jesse Claven
// @raycast.authorURL https://github.com/jesse-c

import AppKit

guard #available(OSX 10.15, *) else {
  print("macOS 10.15 or greater required")
  exit(1)
}

// https://gist.github.com/superhard/6efb324410d8d0588a60
extension NSColor {
  func components() -> ((alpha: String, red: String, green: String, blue: String, css: String), (alpha: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat), (alpha: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat))? {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    if let color = usingColorSpace(NSColorSpace.deviceRGB) {
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
      let nsTuple = (alpha: alpha, red: red, green: green, blue: blue)
      red = round(red * 255.0)
      green = round(green * 255.0)
      blue = round(blue * 255.0)
      alpha = round(alpha * 255.0)
      let xalpha = String(Int(alpha), radix: 16, uppercase: true)
      let xred = String(Int(red), radix: 16, uppercase: true)
      let xgreen = String(Int(green), radix: 16, uppercase: true)
      let xblue = String(Int(blue), radix: 16, uppercase: true)
      let css = "#\(xred)\(xgreen)\(xblue)"
      let hexTuple = (alpha: xalpha, red: xred, green: xgreen, blue: xblue, css: css)
      let rgbTuple = (alpha: alpha, red: red, green: green, blue: blue)
      return (hexTuple, rgbTuple, nsTuple)
    }

    return nil
  }
}

func copyToPasteboard(_ colour: String) {
  NSPasteboard.general.clearContents()
  NSPasteboard.general.writeObjects([colour as NSPasteboardWriting])
}

let sampler = NSColorSampler()

sampler.show { selectedColor in
  if let selectedColor = selectedColor {
    let (hexTuple, _, _) = selectedColor.components()!
    copyToPasteboard(hexTuple.css)
    print("Sampled colour: \(hexTuple.css)")
    exit(0)
  } else {
    print("Sampled colour: none")
    exit(0)
  }
}

RunLoop.main.run()
