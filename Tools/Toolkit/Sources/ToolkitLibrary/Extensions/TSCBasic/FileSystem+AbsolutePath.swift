//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import TSCBasic

extension FileSystem {
  func absolutePath(for path: String) -> AbsolutePath {
    if let path = try? AbsolutePath(validating: path) {
      return path
    } else if
      let path = try? RelativePath(validating: path),
      let currentWorkingDirectory = localFileSystem.currentWorkingDirectory {
      return AbsolutePath(
        path.pathString,
        relativeTo: currentWorkingDirectory
      )
    }

    return localFileSystem.homeDirectory.appending(
      RelativePath(path)
    )
  }
}
