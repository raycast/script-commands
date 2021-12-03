//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import TSCBasic

public final class DataManager {
  private var total: Int = 0 {
    // FIXME: Data racing
    didSet {
      data.totalScriptCommands = total
    }
  }

  var data = RaycastData()

  let extensionsFilePath: AbsolutePath
  let extensionsPath: AbsolutePath

  let fileSystem: FileSystem
  let ignoreGitInformation: Bool

  var isMetadataEmpty: Bool {
    data.metadata.isEmpty
  }

  var extensionsPathString: String {
    extensionsPath.pathString
  }

  public init(extensionsPath: String, extensionsFilename: String = "") throws {
    let fileSystem          = TSCBasic.localFileSystem
    let path                = fileSystem.absolutePath(for: extensionsPath)
    let extensionsFilePath  = path.appending(RelativePath(extensionsFilename))

    guard fileSystem.exists(path) else {
      throw ToolkitError.folderNotFound(path.pathString)
    }

    self.fileSystem           = fileSystem
    self.extensionsPath       = path
    self.extensionsFilePath   = extensionsFilePath
    self.ignoreGitInformation = extensionsFilename.isEmpty
  }

  func increaseTotal() {
    total += 1
  }

  func addLanguage(_ language: String) {
    data.languages.insert(
      Language.Information(name: language)
    )
  }

  func loadContent() {
    if let byteString = try? fileSystem.readFileContents(extensionsPath) {
      let data = byteString.contents.data

      do {
        self.data = try data.decode()
      } catch {
        self.data = RaycastData()
      }
    } else {
      data = RaycastData()
    }
  }
}
