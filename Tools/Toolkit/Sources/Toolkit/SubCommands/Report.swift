//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import ArgumentParser
import SwiftUI
import ToolkitLibrary

extension ToolkitCommand {
  struct Report: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Generate a report about the health of the Script Commands"
    )

    @Option(
      name: [
        .customShort("t"),
        .customLong("type"),
      ],
      help: "\(Toolkit.ReportType.allOptions)\n "
    )
    var reportType: Toolkit.ReportType = .allScripts

    @Argument(
      help: "Path of the Raycast extensions folder.\n "
    )
    var path: String = "./commands"

    @Flag(help: "Print report without colors")
    var noColor: Bool = false

    func run() throws {
      do {
        let dataManager = try DataManager(
          extensionsPath: path
        )

        let toolkit = Toolkit(
          dataManager: dataManager
        )

        try toolkit.report(
          type: reportType,
          noColor: noColor
        )
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
