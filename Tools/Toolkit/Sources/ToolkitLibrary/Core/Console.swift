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
  
  public func writeError(_ message: String, bold: Bool = false) {
    write(string: message, color: .red)
  }
  
  public func writeWarning(_ message: String, bold: Bool = false) {
    write(string: message, color: .yellow)
  }
  
  public func writeSuccess(_ message: String, bold: Bool = false) {
    write(string: message, color: .green)
  }
  
  public func write(_ message: String, bold: Bool = false) {
    write(string: message, color: .noColor, bold: bold)
  }
  
  public func write(string: String, color: TerminalController.Color, bold: Bool = false) {
    terminalController?.write(string, inColor: color, bold: bold)
    terminalController?.endLine()
  }
}
