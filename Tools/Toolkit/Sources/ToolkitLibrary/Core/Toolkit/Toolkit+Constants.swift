//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public extension Toolkit {
  static func version() {
    raycastDescription()
    Console.shared.write("Current version: \(information.version)")
  }
  
}
