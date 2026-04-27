//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

// MARK: - ScriptCommand.Platform

extension ScriptCommand {
  enum Platform: String, Codable {
    case macOS = "macos"
    case windows
  }
}

// MARK: - ScriptCommand.Platform + MarkdownDescriptionProtocol

extension ScriptCommand.Platform: MarkdownDescriptionProtocol {
  var markdownDescription: String {
    switch self {
    case .macOS: "macOS"
    case .windows: "Windows"
    }
  }

  var sectionTitle: String {
    .empty
  }
}
