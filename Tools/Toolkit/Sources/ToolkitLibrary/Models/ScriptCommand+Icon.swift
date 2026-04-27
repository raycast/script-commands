//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

// MARK: - ScriptCommand.Icon

extension ScriptCommand {
  struct Icon: Codable {
    let light: String?
    let dark: String?

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: InputCodingKeys.self)

      light = try container.decodeIfPresent(String.self, forKey: .icon)
      dark = try container.decodeIfPresent(String.self, forKey: .iconDark)
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: OutputCodingKeys.self)

      try container.encode(light, forKey: .light)
      try container.encode(dark, forKey: .dark)
    }
  }
}

// MARK: - Keys

extension ScriptCommand.Icon {
  enum InputCodingKeys: String, CodingKey {
    case icon
    case iconDark
  }

  enum OutputCodingKeys: String, CodingKey {
    case light
    case dark
  }
}

// MARK: - HTML Render

extension ScriptCommand.Icon {
  private func htmlImageTagFor(lightPath: String?, darkPath: String?, folderPath: String) -> String {
    func resolvedURL(_ filepath: String) -> String {
      filepath.isValidURL ? filepath : folderPath + filepath
    }

    if let lightPath, let darkPath {
      // This is the way to make modern HTML change images based on the theme (light or dark) used by the user
      return "<picture><source srcset=\"\(resolvedURL(darkPath))\" media=\"(prefers-color-scheme: dark)\"><img src=\"\(resolvedURL(lightPath))\" width=\"20\" height=\"20\"></picture>"
    } else if let lightPath {
      return "<img src=\"\(resolvedURL(lightPath))\" width=\"20\" height=\"20\">"
    } else if let darkPath {
      return "<img src=\"\(resolvedURL(darkPath))\" width=\"20\" height=\"20\">"
    }

    return .empty
  }

  func imageTag(with path: String) -> String {
    switch (light, dark) {
    case let (light?, dark?) where light.isEmoji && dark.isEmoji:
      light

    case let (light?, dark?) where (light.isImage && dark.isImage) || (light.isValidURL && dark.isValidURL):
      htmlImageTagFor(
        lightPath: light,
        darkPath: dark,
        folderPath: path,
      )

    case let (light?, nil) where light.isEmoji:
      light

    case let (nil, dark?) where dark.isEmoji:
      dark

    case let (light?, nil) where light.isImage || light.isValidURL:
      htmlImageTagFor(
        lightPath: light,
        darkPath: nil,
        folderPath: path,
      )

    case let (nil, dark?) where dark.isImage || dark.isValidURL:
      htmlImageTagFor(
        lightPath: nil,
        darkPath: dark,
        folderPath: path,
      )

    default:
      .empty
    }
  }
}

// MARK: -

private extension String {
  var isImage: Bool {
    hasSuffix(".png") || hasSuffix(".jpeg") || hasSuffix(".jpg") || hasSuffix(".gif") || hasSuffix(".svg")
  }
}
