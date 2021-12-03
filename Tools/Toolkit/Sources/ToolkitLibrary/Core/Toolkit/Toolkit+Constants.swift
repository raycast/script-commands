//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public extension Toolkit {
  var blockedFolderList: [String] {
    [
      ".git",
      "screenshots",
      "Tools",
      ".build",
      ".github",
      "templates",
      "images",
      "_enabled-commands",
      ".swiftpm",
    ]
  }

  var blockedFilesExtensionsList: [String] {
    [
      "txt",
    ]
  }

  static var information: (name: String, version: String) {
    (
      name: "Raycast Toolkit",
      version: "0.4.0"
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
