//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public final class Toolkit {
  private lazy var fileSystem = TSCBasic.localFileSystem

  private var extensionsAbsolutePath: AbsolutePath

  public init(path: AbsolutePath) {
    extensionsAbsolutePath = path
  }

  public func generateDocumentation(
    outputFileName: String = "extensions",
    blockedFolderList: [String] = [".git", "screenshots", "Tools", ".build", ".github"]
  ) throws {
    guard fileSystem.exists(extensionsAbsolutePath) else {
      throw Error.extensionsFolderNotFound(extensionsAbsolutePath.pathString)
    }

    let directoryContent = try fileSystem.getDirectoryContents(extensionsAbsolutePath)

    var groups: Groups = []

    try directoryContent.forEach {
      let path = extensionsAbsolutePath.appending(component: $0)

      guard fileSystem.isDirectory(path) && blockedFolderList.contains($0) == false else {
        return
      }

      let scriptCommands = try readFiles(from: path)
      let group = Group(
        name: path.socialBasename,
        path: path.basenameWithoutExt,
        scriptCommands: scriptCommands
      )

      groups.append(group)
    }

    let documentation = Documentation(
      path: extensionsAbsolutePath,
      filename: outputFileName
    )

    try documentation.generateDocuments(
      using: groups
    )
  }
}

private extension Toolkit {

  func readFiles(from path: AbsolutePath) throws -> ScriptCommands {
    let directoryContent = try fileSystem.getDirectoryContents(path)
    var extensions: ScriptCommands = []

    directoryContent.forEach {
      let filePath = path.appending(component: $0)

      guard fileSystem.isFile(filePath) else {
        return
      }

      guard let fileContent = readFile(from: filePath) else {
        return
      }

      if let object = scriptCommand(with: fileContent, filename: $0, path: path) {
        extensions.append(object)
      }
    }

    return extensions
  }

  func readFile(from path: AbsolutePath) -> String? {
    guard let byteString = try? fileSystem.readFileContents(path) else {
      return nil
    }

    let data = byteString.contents.data
    let content = String(data: data, encoding: .utf8)

    return content
  }

  func scriptCommand(with content: String, filename: String, path: AbsolutePath) -> ScriptCommand? {
    let filenameKey = ScriptCommand.CodingKeys.filename.rawValue
    let packageNameKey = ScriptCommand.CodingKeys.packageName.rawValue

    var dictionary = readKeyValue(of: content)
    dictionary[filenameKey] = filename

    if dictionary[packageNameKey] == nil {
      dictionary[packageNameKey] = path.basenameWithoutExt.sanitize.capitalized
    }

    return dictionary.encodeToStruct()
  }

  func readKeyValue(of content: String) -> [String: Any] {
    let regex = "@raycast.(?<key>[A-Za-z]+)\\s(?<value>[\\S ]+)"
    let results = checkingResults(for: regex, in: content)

    var dictionary = [String: Any]()

    for result in results {
      let keyRange: NSRange = result.range(withName: "key")
      let valueRange: NSRange = result.range(withName: "value")

      var key: String?
      var value: String?

      if keyRange.location != NSNotFound, keyRange.length > 0,
         let range = Range<String.Index>(keyRange, in: content) {
        key = String(content[range])
      }

      if valueRange.location != NSNotFound, valueRange.length > 0,
         let range = Range<String.Index>(valueRange, in: content) {
        value = String(content[range])
      }

      if let key = key, let value = value {

        if let intValue = Int(value) {
          dictionary[key] = intValue
        } else if let boolValue = Bool(value) {
          dictionary[key] = boolValue
        } else {
          dictionary[key] = value
        }
      }
    }

    return dictionary
  }

  func checkingResults(for regex: String, in text: String) -> NSTextCheckingResults {
    do {
      let regex = try NSRegularExpression(
        pattern: regex,
        options: [
          .caseInsensitive,
          .anchorsMatchLines
        ]
      )
      let range = NSRange(text.startIndex..., in: text)

      return regex.matches(in: text, range: range)
    } catch let error {
      print("Invalid regex: \(error.localizedDescription)")
      return []
    }
  }
}
