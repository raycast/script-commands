//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Int {
  var level: String {
    var content: String = .empty

    for _ in 0..<self {
      content += "  "
    }
    return content
  }
}
