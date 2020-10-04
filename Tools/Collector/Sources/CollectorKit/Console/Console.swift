// 
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
// 

import Foundation
import TSCBasic

final class Console {
    private let terminalController: TerminalController?
    
    static let shared = Console()
    
    private init() {
        self.terminalController = TerminalController(stream: stdoutStream)
    }
    
    struct MessageOptions {
        let color: TerminalController.Color
        let bold: Bool = true
    }
    
    func writeError(string: String, bold: Bool = false, file: String = #file, function: String = #function, line: UInt = #line) {
        let errorString = """
        File: \(file) : \(line)
        Function: \(function)
        Message: \(string)
        """
        
        write(string: errorString, color: .red)
    }
    
    func writeWarning(string: String, bold: Bool = false) {
        write(string: string, color: .yellow)
    }
    
    func write(string: String, bold: Bool = false) {
        write(string: string, color: .noColor, bold: bold)
    }
    
    func write(description: String, value: String, valueOptions options: MessageOptions) {
        terminalController?.write(description, inColor: .noColor)
        terminalController?.write(value, inColor: options.color, bold: options.bold)
        terminalController?.endLine()
    }
    
    func write(string: String, color: TerminalController.Color, bold: Bool = false) {
        terminalController?.write(string, inColor: color, bold: bold)
        terminalController?.endLine()
    }
}
