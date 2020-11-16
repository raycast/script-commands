//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

typealias NSTextCheckingResults = [NSTextCheckingResult]

final class RegEx {
  static func checkingResults(for regex: String, in text: String) -> NSTextCheckingResults {
    do {
      let regex = try NSRegularExpression(
        pattern: regex,
        options: [
          .caseInsensitive,
          .anchorsMatchLines
        ]
      )

      let range = NSRange(text.startIndex..., in: text)
      return regex.matches(in: text, range: range)

    } catch let error {
      print("Invalid regex: \(error.localizedDescription)")
      return []
    }
  }
}
