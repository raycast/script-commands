//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
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
          .anchorsMatchLines,
        ]
      )

      let range = NSRange(text.startIndex..., in: text)
      return regex.matches(in: text, range: range)
    } catch {
      print("Invalid regex: \(error.localizedDescription)")
      return []
    }
  }

  static func checkingResult(for regex: String, in text: String) -> NSTextCheckingResult? {
    return checkingResults(for: regex, in: text).first
  }
}
