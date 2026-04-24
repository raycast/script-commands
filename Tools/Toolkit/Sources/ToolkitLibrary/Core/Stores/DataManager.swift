//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

public actor DataManager {
  private var total: Int = 0 {
    didSet {
      data.totalScriptCommands = total
    }
  }

  var data = RaycastData()

  let extensionsFilePath: URL
  let extensionsPath: URL
  let ignoreGitInformation: Bool

  var isMetadataEmpty: Bool {
    data.metadata.isEmpty
  }

  public init(extensionsPath path: String, extensionsFilename: String = "") throws {
    let resolvedPath = URL.resolvingPath(path)

    guard resolvedPath.isDirectory else {
      throw ToolkitError.folderNotFound(resolvedPath.path)
    }

    extensionsPath = resolvedPath
    extensionsFilePath = extensionsFilename.isEmpty
      ? resolvedPath
      : resolvedPath.appendingPathComponent(extensionsFilename)
    ignoreGitInformation = extensionsFilename.isEmpty
  }

  func increaseTotal() {
    total += 1
  }

  func addLanguage(_ language: String) {
    data.languages.insert(
      Language.Information(name: language),
    )
  }

  func setGroups(_ groups: Groups) {
    data.groups = groups
  }

  func loadContent() {
    guard
      !ignoreGitInformation,
      let fileData = try? Data(contentsOf: extensionsFilePath)
    else {
      data = RaycastData()
      return
    }

    do {
      data = try fileData.decode()
    } catch {
      data = RaycastData()
    }
  }
}
