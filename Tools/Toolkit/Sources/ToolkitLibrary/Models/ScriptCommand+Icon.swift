//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

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
  private func htmlImageTag(for lightFilepath: String?, darkFilepath: String?, path: String) -> String {
    if let iconLight = lightFilepath, let iconDark = darkFilepath {
      var darkURL: String { iconDark.isValidURL ? iconDark : path + iconDark }
      var lightURL: String { iconLight.isValidURL ? iconLight : path + iconLight }

      // This is the way to make modern HTML change images based on the theme (light or dark) used by the user
      return "<picture><source srcset=\"\(darkURL)\" media=\"(prefers-color-scheme: dark)\"><img src=\"\(lightURL)\" width=\"20\" height=\"20\"></picture>"
    } else if let icon = lightFilepath {
      var url: String { icon.isValidURL ? icon : path + icon }
      return "<img src=\"\(url)\" width=\"20\" height=\"20\">"
    } else if let icon = darkFilepath {
      var url: String { icon.isValidURL ? icon : path + icon }
      return "<img src=\"\(url)\" width=\"20\" height=\"20\">"
    }

    return .empty
  }

  func imageTag(with path: String) -> String {
    if let iconLight = light, let iconDark = dark {
      if iconLight.isEmoji && iconDark.isEmoji {
        return iconLight
      } else if iconLight.isImage && iconDark.isImage || iconLight.isValidURL && iconDark.isValidURL {
        let tag = htmlImageTag(
          for: iconLight,
          darkFilepath: iconDark,
          path: path
        )
        return tag
      }
    } else if let iconLight = light, iconLight.isEmoji {
      return iconLight
    } else if let iconDark = dark, iconDark.isEmoji {
      return iconDark
    } else if let icon = light, icon.isImage || icon.isValidURL {
      let tag = htmlImageTag(
        for: icon,
        darkFilepath: nil,
        path: path
      )

      return tag
    } else if let icon = dark, icon.isImage || icon.isValidURL {
      let tag = htmlImageTag(
        for: nil,
        darkFilepath: icon,
        path: path
      )

      return tag
    }

    return .empty
  }
}

// MARK: -

private extension String {
  var isImage: Bool {
    hasSuffix(".png") || hasSuffix(".jpeg") || hasSuffix(".jpg") || hasSuffix(".gif")
  }
}
