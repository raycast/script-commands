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
      "-"
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
}
