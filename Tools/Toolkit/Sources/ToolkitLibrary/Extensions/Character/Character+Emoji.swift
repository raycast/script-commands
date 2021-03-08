//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Character {
  var isSimpleEmoji: Bool {
    guard let firstScalar = unicodeScalars.first else {
      return false
    }

    return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
  }

  var isCombinedIntoEmoji: Bool {
    guard unicodeScalars.count > 1, let firstScalar = unicodeScalars.first else {
      return false
    }

    return firstScalar.properties.isEmoji
  }

  var isEmoji: Bool {
    isSimpleEmoji || isCombinedIntoEmoji
  }
}
