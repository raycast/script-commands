//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

public extension Toolkit {
  enum ReportType: String, CaseIterable, CustomStringConvertible {
    case executable
    case nonExecutable = "non-executable"
    case allScripts = "all-scripts"

    public var description: String {
      return rawValue
    }
  }
}
