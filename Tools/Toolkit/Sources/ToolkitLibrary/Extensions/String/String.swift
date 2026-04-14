//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import CryptoKit
import Foundation

// MARK: - StringError

enum StringError: Error {
  case convertStringToData
}

extension String {
  var sanitize: String {
    var text = self

    let entities = [
      "_",
      "-",
    ]

    entities.forEach { entity in
      guard text.contains(entity) else {
        return
      }

      text = text.replacingOccurrences(
        of: entity,
        with: " ",
      )
    }

    return text
  }

  var trimmedString: String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }

  var splitByNewLine: [String] {
    split(separator: .newLine).map(String.init)
  }

  static var newLine: String {
    "\n"
  }

  static var empty: String {
    ""
  }

  func `repeat`(by times: Int) -> String {
    var content = self

    guard times >= 0 else {
      return .empty
    }

    for _ in 0..<times {
      content += self
    }

    return content
  }

  func convertToMD5() throws -> String {
    guard let data = data(using: .utf8) else {
      throw StringError.convertStringToData
    }

    let digest = Insecure.MD5.hash(data: data)

    return digest.map {
      String(format: "%02hhx", $0)
    }
    .joined()
  }
}
