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

  init(_ rawValue: String) {
    let value = rawValue.lowercased()

    switch value {
    case "applescript", "osascript":
      self = .applescript
    case "bash", "zsh", "sh":
      self = .bash
    case "python", "python2", "python3":
      self = .python
    case "ruby":
      self = .ruby
    case "swift":
      self = .swift
    case "node", "js", "zx":
      self = .node
    case "php":
      self = .php
    case "dotnet":
      self = .cs
    default:
      self = .custom(value)
    }
  }

  var icon: String? {
    switch self {
    case .applescript:
      return "icon-applescript.png"
    case .bash:
      return "icon-bash.png"
    case .python:
      return "icon-python.png"
    case .ruby:
      return "icon-ruby.png"
    case .swift:
      return "icon-swift.png"
    case .node:
      return "icon-nodejs.png"
    case .php:
      return "icon-php.png"
    case .cs:
      return "icon-dotnet.png"
    default:
      return nil
    }
  }

  var displayName: String {
    switch self {
    case .applescript:
      return "AppleScript"
    case .bash:
      return "Bash"
    case .python:
      return "Python"
    case .ruby:
      return "Ruby"
    case .swift:
      return "Swift"
    case .node:
      return "Node"
    case .php:
      return "PHP"
    case .cs:
      return ".NET"
    case .custom(let name):
      return name
    }
  }

  var name: String {
    displayName.lowercased()
  }
}

// MARK: -

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
