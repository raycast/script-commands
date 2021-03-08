//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import TSCBasic

extension AbsolutePath {
  var socialBasename: String {
    basenameWithoutExt.sanitize.capitalized
  }
}
