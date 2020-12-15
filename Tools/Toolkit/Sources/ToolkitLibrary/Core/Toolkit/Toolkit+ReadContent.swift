//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

extension Toolkit {

  @discardableResult
  func readFolderContent(path: AbsolutePath,
                         parentGroups: inout Groups,
                         ignoreFilesInDir: Bool = false) throws -> ScriptCommands {
    var scriptCommands = ScriptCommands()

    for directory in onlyDirectories(at: path) {
      guard blockedFolderList.contains(directory.basename) == false else {
        continue
      }

      var group = Group(
        name: directory.socialBasename,
        path: directory.basenameWithoutExt
      )

      var subGroups = Groups()

      let values = try readFolderContent(path: directory, parentGroups: &subGroups)

      if values.count > 0 {
        group.scriptCommands = values
      }

      if subGroups.count > 0 {
        group.subGroups = subGroups
      }

      parentGroups.append(group)
    }

    for file in onlyFiles(at: path) {
      guard ignoreFilesInDir == false else {
        continue
      }

      if var scriptCommand = readScriptCommand(from: file) {
        self.totalScriptCommands += 1
        
        scriptCommand.configure(
          isExecutable: fileSystem.isExecutableFile(file)
        )

        scriptCommands.append(scriptCommand)
      }
    }

    return scriptCommands
  }

  func readContentFile(from path: AbsolutePath) -> String? {
    guard let byteString = try? fileSystem.readFileContents(path) else {
      return nil
    }

    let data = byteString.contents.data
    let content = String(data: data, encoding: .utf8)

    return content
  }

  func readScriptCommand(from filePath: AbsolutePath) -> ScriptCommand? {
    guard fileSystem.isFile(filePath) else {
      return nil
    }

    guard let fileContent = readContentFile(from: filePath) else {
      return nil
    }

    return scriptCommand(
      with: fileContent,
      filename: filePath.basename,
      path: filePath
    )
  }

  func scriptCommand(with content: String, filename: String, path: AbsolutePath) -> ScriptCommand? {
    let filenameKey = ScriptCommand.CodingKeys.filename.rawValue
    let packageNameKey = ScriptCommand.CodingKeys.packageName.rawValue

    // TODO: Use the content of dictionary to implement the validation
    var dictionary = readKeyValues(of: content)
    dictionary[filenameKey] = filename
    
    dictionary["isTemplate"] = filename.contains("template")

    if dictionary[packageNameKey] == nil {
      dictionary[packageNameKey] = path.basenameWithoutExt.sanitize.capitalized
    }

    return dictionary.encodeToStruct()
  }

  func readKeyValues(of content: String) -> [String: Any] {
    let regex = "@raycast.(?<key>[A-Za-z0-9]+)\\s(?<value>[\\S ]+)"
    let results = RegEx.checkingResults(for: regex, in: content)
    
    var dictionary: [String: Any] = [:]

    if let language = extractLanguageFromShebang(using: content) {
      dictionary["language"] = language
    }
    
    let authors = extractAuthors(from: content, using: results)
    if authors.count > 0 {
      dictionary["authors"] = authors
    }
    
    let icons = extractIcons(from: content, using: results)
    if icons.count > 0 {
      dictionary["icon"] = icons
    }
    
    dictionary["hasArguments"] = extractArguments(from: content, using: results)

    for result in results {
      let keyValue = readKeyValue(from: result, content: content)

      guard keyValue.authorKeys == false && keyValue.iconKeys == false else {
        continue
      }
      
      dictionary.merge(keyValue) { $1 }
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
    
    let language = Language(String(software))
    
    return language.name
  }
  
  func extractArguments(from content: String, using results: NSTextCheckingResults) -> Bool {
    var hasArguments = false
    
    for result in results {
      let dictionary = readKeyValue(from: result, content: content)
      
      guard dictionary.argumentsKeys else {
        continue
      }
      
      hasArguments = true
    }
    
    return hasArguments
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
    var value: String?

    if range.location != NSNotFound, range.length > 0,
       let rangeString = Range<String.Index>(range, in: content) {
      value = String(content[rangeString])
    }

    return value
  }
}

// MARK: - Filter Extensions

fileprivate extension Toolkit {
  enum ContentDirType {
    case directories
    case files
  }

  func onlyFiles(at path: AbsolutePath) -> [AbsolutePath] {
    return folderContent(type: .files, for: path)
  }

  func onlyDirectories(at path: AbsolutePath) -> [AbsolutePath] {
    return folderContent(type: .directories, for: path)
  }

  func folderContent(type: ContentDirType, for path: AbsolutePath) -> [AbsolutePath] {
    do {
      let directoryContent = try fileSystem.getDirectoryContents(path)

      let pathsForType: [AbsolutePath] = directoryContent.compactMap {
        let contentPath = path.appending(component: $0)

        guard check(type, for: contentPath) else {
          return nil
        }

        return contentPath
      }

      return pathsForType
    } catch {
      return []
    }
  }

  private func check(_ type: ContentDirType, for path: AbsolutePath) -> Bool {
    switch type {
    case .directories:
      return fileSystem.isDirectory(path)
    case .files:
      return fileSystem.isFile(path)
    }
  }
}

// MARK: - Dictionary Extension

fileprivate extension Dictionary where Key == String {
  var authorKeys: Bool {
    typealias Keys = ScriptCommand.Author.InputCodingKeys
    let authorNameKey = Keys.name.rawValue
    let authorURLKey = Keys.url.rawValue

    guard let key = keys.first else {
      return false
    }

    return key == authorNameKey || key == authorURLKey
  }
  
  var iconKeys: Bool {
    typealias Keys = ScriptCommand.Icon.InputCodingKeys
    let iconKey = Keys.icon.rawValue
    let iconDarkKey = Keys.iconDark.rawValue
    
    guard let key = keys.first else {
      return false
    }
    
    return key == iconKey || key == iconDarkKey
  }
  
  var argumentsKeys: Bool {
    guard let key = keys.first else {
      return false
    }
    
    return key == "argument1" || key == "argument2" || key == "argument3"
  }
}
