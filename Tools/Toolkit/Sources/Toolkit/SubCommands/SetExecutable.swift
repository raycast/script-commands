//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary

extension ToolkitCommand {
  struct SetExecutable: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Set file mode \"executable\" to Script Commands"
    )

    @Argument(help: "Path of the Raycast extensions folder.\n")
    var path: String = "./commands"

    func run() throws {
      do {
        let dataManager = try DataManager(
          extensionsPath: path
        )

        let toolkit = Toolkit(
          dataManager: dataManager
        )

        try toolkit.setScriptCommandsAsExecutable()
      } catch {
        Toolkit.raycastDescription()
        Console.shared.writeRed("Error: \(error)")
      }
    }
  }
}
