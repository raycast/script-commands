//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

// MARK: - Language

enum Language {
  case applescript
  case bash
  case dotnet
  case node
  case php
  case powershell
  case python
  case ruby
  case swift
  case custom(String)

  private struct Meta {
    let name: String
    let displayName: String
    let icon: String?
    let aliases: [String]

    init(name: String, displayName: String, icon: String? = nil, aliases: [String] = []) {
      self.name = name
      self.displayName = displayName
      self.icon = icon
      self.aliases = aliases
    }

    static func notIdentified() -> Self {
      .init(
        name: .empty,
        displayName: "Language Not Identified",
        icon: nil,
        aliases: [],
      )
    }
  }

  private static let knownCases: [(language: Language, meta: Meta)] = [
    (
      .applescript,
      Meta(name: "applescript", displayName: "AppleScript", icon: "icon-applescript.png", aliases: ["osascript"]),
    ),
    (
      .bash,
      Meta(name: "bash", displayName: "Bash", icon: "icon-bash.png", aliases: ["zsh", "sh"])),
    (
      .dotnet,
      Meta(name: "dotnet", displayName: ".NET", icon: "icon-dotnet.png", aliases: ["cs"])),
    (
      .node,
      Meta(name: "node", displayName: "Node", icon: "icon-nodejs.png", aliases: ["js", "zx"])),
    (
      .php,
      Meta(name: "php", displayName: "PHP", icon: "icon-php.png")),
    (
      .powershell,
      Meta(name: "pwsh", displayName: "PowerShell", icon: "icon-powershell.png", aliases: ["ps1"])),
    (
      .python,
      Meta(name: "python", displayName: "Python", icon: "icon-python.png", aliases: ["python2", "python3"]),
    ),
    (
      .ruby,
      Meta(name: "ruby", displayName: "Ruby", icon: "icon-ruby.png"),
    ),
    (
      .swift,
      Meta(name: "swift", displayName: "Swift", icon: "icon-swift.png"),
    ),
  ]

  private var meta: Meta {
    switch self {
    case let .custom(language):
      Meta(name: language, displayName: language.capitalized)

    default:
      Language.knownCases.first {
        $0.language == self
      }?.meta
        ?? .notIdentified() // `.notIdentified()` should never be used
    }
  }

  init(_ rawValue: String) {
    let value = rawValue.lowercased()

    for (language, meta) in Language.knownCases {
      if meta.name == value || meta.aliases.contains(value) {
        self = language
        return
      }
    }

    self = .custom(value)
  }

  var name: String {
    meta.name
  }

  var displayName: String {
    meta.displayName
  }

  var icon: String? {
    meta.icon
  }
}

// MARK: - Equatable

extension Language: Equatable {}

// MARK: - MarkdownDescriptionProtocol

extension Language: MarkdownDescriptionProtocol {
  var markdownDescription: String {
    if let icon {
      return "<img src=\"images/\(icon)\" width=\"20\" height=\"20\" title=\"\(displayName)\">"
    }

    return displayName
  }

  var sectionTitle: String {
    .empty
  }
}
