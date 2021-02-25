//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

extension String {
  var sanitize: String {
    var text = self

    let entities = [
      "_",
      "-",
    ]

    entities.forEach { entity in
      guard text.contains(entity) else {
        return
      }

      text = text.replacingOccurrences(
        of: entity,
        with: " "
      )
    }

    return text
  }

  var trimmedString: String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }

  static var newLine: String {
    "\n"
  }

  static var empty: String {
    ""
  }

  func `repeat`(by times: Int) -> String {
    var content = self

    guard times >= 0 else {
      return .empty
    }

    for _ in 0..<times {
      content += self
    }

    return content
  }
}
