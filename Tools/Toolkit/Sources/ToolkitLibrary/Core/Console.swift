//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public final class Console {
  private let terminalController: TerminalController?

  public static let shared = Console()

  private init() {
    self.terminalController = TerminalController(stream: stdoutStream)
  }

  public func writeRed(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(string: message, color: .red, bold: bold, endLine: endLine)
  }

  public func writeYellow(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(string: message, color: .yellow, bold: bold, endLine: endLine)
  }

  public func writeGreen(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(string: message, color: .green, bold: bold, endLine: endLine)
  }

  public func write(_ message: String, bold: Bool = false, endLine: Bool = true) {
    write(string: message, color: .noColor, bold: bold, endLine: endLine)
  }

  public func write(string: String, color: TerminalController.Color, bold: Bool = false, endLine: Bool = true) {
    terminalController?.write(string, inColor: color, bold: bold)

    if endLine {
      terminalController?.endLine()
    }
  }
}
