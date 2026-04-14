//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

enum ToolkitError: Swift.Error, CustomStringConvertible, LocalizedError {
  case folderNotFound(String)
  case fileNotFound(String)

  var description: String {
    switch self {
    case let .folderNotFound(folder):
      "Folder not found. Expected: \(folder)"
    case let .fileNotFound(file):
      "File \"\(file)\" not found"
    }
  }
}
