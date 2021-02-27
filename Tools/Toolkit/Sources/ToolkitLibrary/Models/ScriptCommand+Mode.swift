//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension ScriptCommand {
  enum Mode: String, Codable {
    case fullOutput
    case compact
    case silent
    case inline
  }
}
