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
      "_enabled-commands"
    ]
  }
  
  static var information: (name: String, version: String) {
    (
      name: "Raycast Toolkit",
      version: "0.1"
    )
  }
  
  static func raycastDescription() {
    Console.shared.write(string: information.name, color: .red, bold: true)
  }

  static func version() {
    raycastDescription()
    Console.shared.write("Current version: \(information.version)")
  }
  
}
