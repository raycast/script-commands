//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary
import TSCBasic
import SwiftUI

extension ToolkitCommand {
  
  struct Report: ParsableCommand {
    
    static var configuration = CommandConfiguration(
      abstract: "Generate a report about the health of the Script Commands available in a path"
    )
    
    @Option(
        name: [
            .customShort("t"),
            .customLong("type")
        ],
        help: "\(Toolkit.ReportType.allOptions)\n "
    )
    var reportType: Toolkit.ReportType = .bothExecNonExec
    
    @Argument(
        help: "Path of the Raycast extensions folder.\n "
    )
    var path: String = "./commands"
    
    func run() throws {
      let fileSystem = TSCBasic.localFileSystem

      do {
        let toolkit = Toolkit(
          path: fileSystem.absolutePath(for: path)
        )

        try toolkit.report(type: reportType)
      } catch {
        Toolkit.raycastDescription()
        Console.shared.writeRed("Error: \(error)")
      }
    }
  }
}

// MARK: - Expressible By Argument

extension ToolkitLibrary.Toolkit.ReportType: ExpressibleByArgument {
  static var allOptions: String {
    Self.allValueStrings.joined(separator: "|")
  }
}
