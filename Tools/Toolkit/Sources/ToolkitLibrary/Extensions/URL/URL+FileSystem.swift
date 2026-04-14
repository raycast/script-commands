//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

extension URL {
  /// The last path component without its file extension, with hyphens/underscores replaced
  /// by spaces and the result capitalized. Mirrors the old `AbsolutePath.socialBasename`.
  var socialBasename: String {
    deletingPathExtension().lastPathComponent.sanitize.capitalized
  }

  var isFile: Bool {
    var isDir: ObjCBool = false
    let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
    return exists && !isDir.boolValue
  }

  var isDirectory: Bool {
    var isDir: ObjCBool = false
    let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
    return exists && isDir.boolValue
  }

  var isExecutableFile: Bool {
    FileManager.default.isExecutableFile(atPath: path)
  }

  func setExecutable() throws {
    try FileManager.default.setAttributes(
      [.posixPermissions: NSNumber(value: Int16(0o755))],
      ofItemAtPath: path,
    )
  }

  /// Resolves a path string to an absolute URL.
  /// Handles absolute paths, tilde-prefixed paths, and relative-to-cwd paths.
  static func resolvingPath(_ path: String) -> URL {
    if path.hasPrefix("/") {
      return URL(fileURLWithPath: path)
    }

    if path.hasPrefix("~") {
      let expanded = NSString(string: path).expandingTildeInPath
      return URL(fileURLWithPath: expanded)
    }

    let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    return cwd.appendingPathComponent(path)
  }
}
