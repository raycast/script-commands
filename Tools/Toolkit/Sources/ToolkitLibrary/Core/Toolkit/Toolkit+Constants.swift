//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public extension Toolkit {

  internal var blockedFolderList: [String] {
    [
      ".git",
      "screenshots",
      "Tools",
      ".build",
      ".github",
      "templates",
      "images",
      "_enabled-commands",
      ".swiftpm"
    ]
  }

  static var information: (name: String, version: String) {
    (
      name: "Raycast Toolkit",
      version: "0.2"
    )
  }

  static func raycastDescription() {
    Console.shared.writeRed(information.name, bold: true)
  }

  static func version() {
    raycastDescription()
    Console.shared.write("Current version: ", endLine: false)
    Console.shared.writeYellow(information.version, bold: true)
  }
}
