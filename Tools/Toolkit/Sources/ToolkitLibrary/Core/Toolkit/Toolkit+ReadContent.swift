//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

extension Toolkit {
  typealias FolderContent = (
    scriptCommands: ScriptCommands,
    readmePath: String?,
    groupName: String,
    subGroups: Groups,
  )

  func readFolderContent(path: URL, ignoreFilesInDir: Bool = false) async throws -> FolderContent {
    let directories = onlyDirectories(at: path)
      .filter { !blockedFolderList.contains($0.lastPathComponent) }

    // Process subdirectories concurrently
    let subGroups: Groups = try await withThrowingTaskGroup(of: Group?.self) { taskGroup in
      for directory in directories {
        taskGroup.addTask {
          let content = try await self.readFolderContent(path: directory)

          var group = Group(
            name: directory.socialBasename,
            path: directory.lastPathComponent,
          )

          if !content.groupName.isEmpty,
             content.groupName.lowercased() == group.name.lowercased() {
            group.name = content.groupName
          }

          if !content.scriptCommands.isEmpty {
            group.scriptCommands = content.scriptCommands
          }

          if !content.subGroups.isEmpty {
            group.subGroups = content.subGroups
          }

          if let readmePath = content.readmePath {
            group.readme = readmePath
          }

          guard !content.scriptCommands.isEmpty || !content.subGroups.isEmpty else {
            return nil
          }

          return group
        }
      }

      var results = Groups()
      for try await group in taskGroup {
        if let group {
          results.append(group)
        }
      }
      return results
    }

    var scriptCommands = ScriptCommands()
    var groupName = ""
    var readmePath: String?

    if !ignoreFilesInDir {
      for file in onlyFiles(at: path) {
        let ext = file.pathExtension

        guard !ext.isEmpty, !blockedFilesExtensionsList.contains(ext) else {
          continue
        }

        if file.deletingPathExtension().lastPathComponent.lowercased() == "readme" {
          guard let content = readContentFile(from: file), !content.isEmpty else {
            continue
          }
          let pathCount = dataManager.extensionsPathString.count + 1
          readmePath = String(file.path.dropFirst(pathCount))
        } else if var scriptCommand = await readScriptCommand(from: file) {
          await dataManager.increaseTotal()
          await dataManager.addLanguage(scriptCommand.language)

          scriptCommand.configure(isExecutable: file.isExecutableFile)

          if let packageName = scriptCommand.packageName {
            groupName = packageName
          }

          scriptCommands.append(scriptCommand)
        }
      }
    }

    return (
      scriptCommands: scriptCommands,
      readmePath: readmePath,
      groupName: groupName,
      subGroups: subGroups,
    )
  }

  func readContentFile(from url: URL) -> String? {
    guard let data = try? Data(contentsOf: url) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }

  func extractGitDates(from fileURL: URL) async -> [String]? {
    do {
      let dates = try await git.run(
        "log", "--format=%aI", "--follow", fileURL.lastPathComponent,
        path: fileURL,
      )
      return dates.splitByNewLine
    } catch {
      return nil
    }
  }

  func readScriptCommand(from fileURL: URL) async -> ScriptCommand? {
    guard fileURL.isFile else {
      return nil
    }

    guard let fileContent = readContentFile(from: fileURL) else {
      return nil
    }

    let dictionary = await keyValue(
      for: fileContent,
      filename: fileURL.lastPathComponent,
      fileURL: fileURL,
    )

    return ScriptCommand(from: dictionary)
  }

  func keyValue(for content: String, filename: String, fileURL: URL) async -> [String: Any] {
    let filenameKey = ScriptCommand.CodingKeys.filename.rawValue
    let packageNameKey = ScriptCommand.CodingKeys.packageName.rawValue

    var dictionary = readKeyValues(of: content)
    dictionary[filenameKey] = filename

    let pathCount = dataManager.extensionsPathString.count + 1
    let parentDir = fileURL.deletingLastPathComponent().path
    let scriptPath = String(parentDir.dropFirst(pathCount))
    dictionary["path"] = "\(scriptPath)/"

    if !dataManager.ignoreGitInformation {
      if let dates = await extractGitDates(from: fileURL), !dates.isEmpty {
        if let updatedAt = dates.first {
          dictionary["updatedAt"] = updatedAt
        }
        if let createdAt = dates.last {
          dictionary["createdAt"] = createdAt
        }
      }
    } else {
      dictionary["updatedAt"] = String.empty
      dictionary["createdAt"] = String.empty
    }

    dictionary["isTemplate"] = filename.contains("template")

    if dictionary[packageNameKey] == nil {
      dictionary[packageNameKey] = fileURL.deletingPathExtension().lastPathComponent
        .sanitize.capitalized
    }

    return dictionary
  }

  func readKeyValues(of content: String) -> [String: Any] {
    let regex = "@raycast.(?<key>[A-Za-z0-9]+)\\s(?<value>[\\S ]+)"
    let results = RegEx.checkingResults(for: regex, in: content)

    var dictionary: [String: Any] = [:]

    if let language = extractLanguageFromShebang(using: content) {
      dictionary["language"] = language
    }

    let authors = extractAuthors(from: content, using: results)
    if !authors.isEmpty {
      dictionary["authors"] = authors
    }

    let icons = extractIcons(from: content, using: results)
    if !icons.isEmpty {
      dictionary["icon"] = icons
    }

    dictionary["hasArguments"] = extractArguments(from: content, using: results)

    for result in results {
      let keyValue = readKeyValue(from: result, content: content)

      guard !keyValue.authorKeys, !keyValue.iconKeys else {
        continue
      }

      dictionary.merge(keyValue) { $1 }
    }

    // Normalize platform value to lowercase for case-insensitive enum matching
    if let platformValue = dictionary["platform"] as? String {
      dictionary["platform"] = platformValue.lowercased()
    }

    return dictionary
  }

  func extractLanguageFromShebang(using content: String) -> String? {
    let regex = "#!(?<shebang>[^\n]+)"

    guard let result = RegEx.checkingResult(for: regex, in: content) else {
      return nil
    }

    let range = result.range(withName: "shebang")

    guard let shebang = self.content(of: range, on: content) else {
      return nil
    }

    guard var software = shebang.split(separator: "/").last else {
      return nil
    }

    let values = software.split(separator: " ")

    if values.count > 1 {
      software = values.first == "env"
        ? values.last ?? ""
        : values.first ?? ""
    }

    let name = String(software).trimmedString
    let language = Language(name)

    return language.name
  }

  func extractArguments(from content: String, using results: NSTextCheckingResults) -> Bool {
    for result in results {
      let dictionary = readKeyValue(from: result, content: content)
      if dictionary.argumentsKeys {
        return true
      }
    }
    return false
  }

  func extractIcons(from content: String, using results: NSTextCheckingResults) -> [String: String] {
    var icons: [String: String] = [:]

    for result in results {
      let dictionary = readKeyValue(from: result, content: content)

      guard let key = dictionary.keys.first, dictionary.iconKeys else {
        continue
      }

      if let value = dictionary[key] as? String {
        icons[key] = value
      }
    }

    return icons
  }

  func extractAuthors(from content: String, using results: NSTextCheckingResults) -> [[String: String]] {
    var authors: [[String: String]] = []
    var currentAuthor: [String: String] = [:]

    for result in results {
      let dictionary = readKeyValue(from: result, content: content)

      guard let key = dictionary.keys.first, dictionary.authorKeys else {
        continue
      }

      if currentAuthor.keys.count == 2 {
        currentAuthor = [:]
      }

      if let value = dictionary[key] as? String {
        currentAuthor[key] = value
      }

      if currentAuthor.keys.count == 2 {
        guard let value = dictionary[key] as? String else {
          continue
        }

        guard !authors.contains(where: { $0[key] == value }) else {
          currentAuthor = [:]
          continue
        }

        authors.append(currentAuthor)
        currentAuthor = [:]
      }
    }

    if currentAuthor.keys.count == 1 {
      authors.append(currentAuthor)
    }

    return authors
  }

  func readKeyValue(from result: NSTextCheckingResult, content: String) -> [String: Any] {
    var dictionary = [String: Any]()

    let keyRange = result.range(withName: "key")
    let valueRange = result.range(withName: "value")

    if let key = self.content(of: keyRange, on: content),
       let value = self.content(of: valueRange, on: content) {
      if let intValue = Int(value) {
        dictionary[key] = intValue
      } else if let boolValue = Bool(value) {
        dictionary[key] = boolValue
      } else {
        dictionary[key] = value
      }
    }

    return dictionary
  }

  func content(of range: NSRange, on content: String) -> String? {
    guard range.location != NSNotFound,
          range.length > 0,
          let rangeString = Range<String.Index>(range, in: content)
    else {
      return nil
    }
    return String(content[rangeString])
  }
}

// MARK: - Filter Helpers

private extension Toolkit {
  enum ContentDirType {
    case directories
    case files
  }

  func onlyFiles(at path: URL) -> [URL] {
    folderContent(type: .files, for: path)
  }

  func onlyDirectories(at path: URL) -> [URL] {
    folderContent(type: .directories, for: path)
  }

  func folderContent(type: ContentDirType, for path: URL) -> [URL] {
    guard let contents = try? FileManager.default.contentsOfDirectory(
      at: path,
      includingPropertiesForKeys: [.isDirectoryKey, .isRegularFileKey],
      options: [.skipsHiddenFiles],
    )
    else {
      return []
    }

    return contents.filter { check(type, for: $0) }
  }

  func check(_ type: ContentDirType, for url: URL) -> Bool {
    switch type {
    case .directories: url.isDirectory
    case .files: url.isFile
    }
  }
}

// MARK: - Dictionary Extension

private extension Dictionary where Key == String {
  var authorKeys: Bool {
    typealias Keys = ScriptCommand.Author.InputCodingKeys
    guard let key = keys.first else {
      return false
    }
    return key == Keys.name.rawValue || key == Keys.url.rawValue
  }

  var iconKeys: Bool {
    typealias Keys = ScriptCommand.Icon.InputCodingKeys
    guard let key = keys.first else {
      return false
    }
    return key == Keys.icon.rawValue || key == Keys.iconDark.rawValue
  }

  var argumentsKeys: Bool {
    guard let key = keys.first else {
      return false
    }
    return key == "argument1" || key == "argument2" || key == "argument3"
  }
}
