//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

enum ToolkitError: Swift.Error, CustomStringConvertible, LocalizedError {
  case folderNotFound(String)
  case fileNotFound(String)

  var description: String {
    switch self {
    case .folderNotFound(let folder):
      return "Folder not found. Expected: \(folder)"
    case .fileNotFound(let file):
      return "File \"\(file)\" not found"
    }
  }
}
