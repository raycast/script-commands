//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

public final class Console: @unchecked Sendable {
  private enum ANSI {
    static let bold   = "\u{001B}[1m"
    static let red    = "\u{001B}[31m"
    static let green  = "\u{001B}[32m"
    static let yellow = "\u{001B}[33m"
    static let reset  = "\u{001B}[0m"
  }

  public static let shared = Console()

  init() {}

  public func writeRed(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(message, color: ANSI.red, bold: bold, endLine: endLine)
  }

  public func writeYellow(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(message, color: ANSI.yellow, bold: bold, endLine: endLine)
  }

  public func writeGreen(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(message, color: ANSI.green, bold: bold, endLine: endLine)
  }

  public func write(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(message, color: nil, bold: bold, endLine: endLine)
  }

  public func endLine() {
    print()
  }
}

// MARK: - Private

private extension Console {
  func write(_ message: String, color: String?, bold: Bool, endLine: Bool) {
    var output = ""

    if bold { output += ANSI.bold }
    if let c  = color { output += c }

    output += message

    if bold || color != nil { output += ANSI.reset }

    if endLine {
      print(output)
    } else {
      print(output, terminator: "")
    }
  }
}
