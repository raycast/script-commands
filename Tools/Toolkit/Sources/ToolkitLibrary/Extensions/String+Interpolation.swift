//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension String.StringInterpolation {
  mutating func appendInterpolation(indent: Int, newLine: Bool = true) {
    appendInterpolation("\(newLine ? String.newLine : .empty)\(indent.level)")
  }
}
