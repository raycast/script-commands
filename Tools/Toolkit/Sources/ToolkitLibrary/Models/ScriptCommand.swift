//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

typealias ScriptCommands = [ScriptCommand]

struct ScriptCommand: Codable {
  let identifier: String
  let schemaVersion: Int
  let title: String
  var filename: String
  let mode: Mode?
  var packageName: String?
  let icon: Icon?
  let authors: [Author]?
  let details: String?
  let currentDirectoryPath: String?
  let needsConfirmation: Bool?
  let refreshTime: String?
  let language: String
  let isTemplate: Bool
  let hasArguments: Bool
  let createdAt: String
  let updatedAt: String
  var path: String

  private(set) var isExecutable: Bool = false

  enum CodingKeys: String, CodingKey {
    case identifier
    case schemaVersion
    case title
    case filename
    case mode
    case packageName
    case icon
    case authors
    case details = "description"
    case currentDirectoryPath
    case needsConfirmation
    case refreshTime
    case language
    case isTemplate
    case hasArguments
    case createdAt
    case updatedAt
    case path
  }

  var iconDescription: String {
    guard let icon = self.icon else {
      return .empty
    }

    let path = "https://raw.githubusercontent.com/raycast/script-commands/master/commands/\(self.path)"

    let tag = icon.imageTag(
      with: path
    )

    return tag
  }

  var fullPath: String {
    "\(path)\(filename)"
  }

  mutating func configure(isExecutable: Bool) {
    self.isExecutable = isExecutable
  }
}

// MARK: - Encode/Decode

extension ScriptCommand {
  init?(from dictionary: [String: Any]) {
    if let scriptCommand: ScriptCommand = dictionary.encodeToStruct() {
      self = scriptCommand
    } else {
      return nil
    }
  }

  init(from decoder: Decoder) throws {
    let container      = try decoder.container(keyedBy: CodingKeys.self)

    // Required
    self.schemaVersion = try container.decode(Int.self, forKey: .schemaVersion)
    self.title         = try container.decode(String.self, forKey: .title)
    self.language      = try container.decode(String.self, forKey: .language)
    self.isTemplate    = try container.decode(Bool.self, forKey: .isTemplate)
    self.hasArguments  = try container.decode(Bool.self, forKey: .hasArguments)
    self.path          = try container.decode(String.self, forKey: .path)

    let filename       = try container.decode(String.self, forKey: .filename)
    let createdAt      = try container.decode(String.self, forKey: .createdAt)
    let updatedAt      = try container.decode(String.self, forKey: .updatedAt)

    self.filename  = filename
    self.createdAt = createdAt
    self.updatedAt  = updatedAt

    do {
      let value = "\(createdAt.description)\(filename)"
      let identifier = try value.convertToMD5()

      self.identifier = identifier
    } catch let error as StringError {
      fatalError(error.localizedDescription)
    }

    // Optionals
    self.mode                   = try container.decodeIfPresent(Mode.self, forKey: .mode)
    self.packageName            = try container.decodeIfPresent(String.self, forKey: .packageName)
    self.icon                   = try container.decodeIfPresent(Icon.self, forKey: .icon)
    self.details                = try container.decodeIfPresent(String.self, forKey: .details)
    self.currentDirectoryPath   = try container.decodeIfPresent(String.self, forKey: .currentDirectoryPath)
    self.needsConfirmation      = try container.decodeIfPresent(Bool.self, forKey: .needsConfirmation)
    self.refreshTime            = try container.decodeIfPresent(String.self, forKey: .refreshTime)
    self.authors                = try container.decodeIfPresent(Authors.self, forKey: .authors)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(identifier, forKey: .identifier)
    try container.encode(schemaVersion, forKey: .schemaVersion)
    try container.encode(title, forKey: .title)
    try container.encode(filename, forKey: .filename)
    try container.encode(mode, forKey: .mode)
    try container.encode(packageName, forKey: .packageName)
    try container.encode(icon, forKey: .icon)
    try container.encode(details, forKey: .details)
    try container.encode(currentDirectoryPath, forKey: .currentDirectoryPath)
    try container.encode(authors, forKey: .authors)
    try container.encode(needsConfirmation, forKey: .needsConfirmation)
    try container.encode(refreshTime, forKey: .refreshTime)
    try container.encode(language, forKey: .language)
    try container.encode(isTemplate, forKey: .isTemplate)
    try container.encode(hasArguments, forKey: .hasArguments)
    try container.encode(createdAt, forKey: .createdAt)
    try container.encode(updatedAt, forKey: .updatedAt)
    try container.encode(path, forKey: .path)
  }
}

// MARK: - Comparable

extension ScriptCommand: Comparable {
  static func < (lhs: ScriptCommand, rhs: ScriptCommand) -> Bool {
    lhs.title < rhs.title
  }

  static func == (lhs: ScriptCommand, rhs: ScriptCommand) -> Bool {
    lhs.title == rhs.title
      && lhs.schemaVersion == rhs.schemaVersion
      && lhs.authors == rhs.authors
  }
}

// MARK: - MarkdownDescription Protocol

extension ScriptCommand: MarkdownDescriptionProtocol {
  var markdownDescription: String {
    var content: String = .empty

    var author = "Raycast"
    var details = "N/A"

    if let value = self.authors {
      author = value.markdownDescription
    }

    if let value = self.details {
      details = value.replacingOccurrences(of: "|", with: #"\|"#)
    }

    let language = Language(self.language).markdownDescription
    let scriptPath = "\(path)\(filename)"

    let header = """
      | \(iconDescription) | [\(title)](\(scriptPath)) | \(details) | \(author) | \(hasArguments ? "✅" : "") | \(isTemplate ? "✅" : "") | \(language) |
    """

    content += .newLine + header

    return content
  }

  var sectionTitle: String {
    .empty
  }
}
