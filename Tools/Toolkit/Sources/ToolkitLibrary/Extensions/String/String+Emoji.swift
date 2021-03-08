//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension String {
  var isEmoji: Bool {
    count == 1 && containsEmoji
  }

  var containsEmoji: Bool {
    contains {
      $0.isEmoji
    }
  }

  var containsOnlyEmoji: Bool {
    isEmpty == false &&
      contains {
        $0.isEmoji == false
      } == false
  }
}
