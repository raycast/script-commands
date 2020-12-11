//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

enum Language {
  case applescript
  case bash
  case python
  case ruby
  case swift
  case custom(String)

  init(_ rawValue: String) {
    let value = rawValue.lowercased()

    switch value {
      case "applescript", "osascript":
        self = .applescript
      case "bash", "zsh":
        self = .bash
      case "python", "python2", "python3":
        self = .python
      case "ruby":
        self = .ruby
      case "swift":
        self = .swift
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
      default:
        return nil
    }
  }

  var socialName: String {
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
      case .custom(let name):
        return name
    }
  }

  var name: String {
    switch self {
      case .applescript:
        return "applescript"
      case .bash:
        return "bash"
      case .python:
        return "python"
      case .ruby:
        return "ruby"
      case .swift:
        return "swift"
      case .custom(let name):
        return name.lowercased()
    }
  }
}

// MARK: -

extension Language: MarkdownDescriptionProtocol {
  var markdownDescription: String {
    if let iconFilename = icon {
      return "<img src=\"images/\(iconFilename)\" width=\"20\" height=\"20\" title=\"\(socialName)\">"
      //return "![\(socialName)](images/\(iconFilename) \"\(socialName)\")"
    }

    return socialName
  }

  var sectionTitle: String {
    .empty
  }
}
