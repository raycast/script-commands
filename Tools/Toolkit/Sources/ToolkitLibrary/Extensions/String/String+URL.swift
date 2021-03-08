//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension String {
  var isValidURL: Bool {
    guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
      return false
    }

    if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count)) {
      return match.range.length == self.utf16.count
    }

    return false
  }
}
