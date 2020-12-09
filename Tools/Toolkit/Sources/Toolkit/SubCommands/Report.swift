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
    
    @Option(name: [.customShort("t") , .customLong("type")], help: "Type of report")
    var reportType: ReportType = .nonExecutable
    
    @Argument(help: "Path of the Raycast extensions folder.\n")
    var path: String = "./commands"
    
    func run() throws {
      // TODO: To be implemented
      
//      let fileSystem = TSCBasic.localFileSystem
//
//      do {
//        let toolkit = Toolkit(
//          path: fileSystem.absolutePath(for: path)
//        )
//
//        // TODO: Report
//
//        Toolkit.raycastDescription()
//        Console.shared.writeGreen("Documents generated!")
//      } catch {
//        Toolkit.raycastDescription()
//        Console.shared.writeRed("Error: \(error)")
//      }
    }
  }
}

extension ToolkitCommand.Report {
  enum ReportType: String, CaseIterable, Codable, CustomStringConvertible {
    case executable
    case nonExecutable = "non-executable"
    case metadata
    
    var description: String {
      return rawValue
    }
    
    var dirname: String {
      description
    }
  }
}

extension ToolkitCommand.Report.ReportType: ExpressibleByArgument {}
