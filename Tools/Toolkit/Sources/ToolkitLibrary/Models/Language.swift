//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

enum Language {
  case applescript
  case bash
  case python
  case ruby
  case swift
  case node
  case php
  case dotnet
  case custom(String)

  private struct Meta {
    let name: String
    let displayName: String
    let icon: String?
    let aliases: [String]
  }

  private static let knownCases: [(Language, Meta)] = [
    (.applescript, Meta(name: "applescript", displayName: "AppleScript", icon: "icon-applescript.png", aliases: ["osascript"])),
    (.bash,        Meta(name: "bash",        displayName: "Bash",        icon: "icon-bash.png",        aliases: ["zsh", "sh"])),
    (.python,      Meta(name: "python",      displayName: "Python",      icon: "icon-python.png",      aliases: ["python2", "python3"])),
    (.ruby,        Meta(name: "ruby",        displayName: "Ruby",        icon: "icon-ruby.png",        aliases: [])),
    (.swift,       Meta(name: "swift",       displayName: "Swift",       icon: "icon-swift.png",       aliases: [])),
    (.node,        Meta(name: "node",        displayName: "Node",        icon: "icon-nodejs.png",      aliases: ["js", "zx"])),
    (.php,         Meta(name: "php",         displayName: "PHP",         icon: "icon-php.png",         aliases: [])),
    (.dotnet,      Meta(name: "dotnet",      displayName: ".NET",        icon: "icon-dotnet.png",      aliases: ["cs"])),
  ]

  private var meta: Meta {
    switch self {
    case .custom(let value):
      return Meta(name: value, displayName: value, icon: nil, aliases: [])
    default:
      return Language.knownCases.first { $0.0 == self }!.1
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

  var name: String { meta.name }
  var displayName: String { meta.displayName }
  var icon: String? { meta.icon }
}

// MARK: -

extension Language: Equatable {}

extension Language: MarkdownDescriptionProtocol {
  var markdownDescription: String {
    if let iconFilename = icon {
      return "<img src=\"images/\(iconFilename)\" width=\"20\" height=\"20\" title=\"\(displayName)\">"
    }

    return displayName
  }

  var sectionTitle: String {
    .empty
  }
}
