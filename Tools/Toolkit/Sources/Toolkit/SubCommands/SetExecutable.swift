//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary

extension ToolkitCommand {
  struct SetExecutable: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
      abstract: "Set file mode \"executable\" to Script Commands",
    )

    @Argument(help: "Path of the Raycast extensions folder.\n")
    var path: String = "./commands"

    func run() async throws {
      do {
        let dataManager = try DataManager(extensionsPath: path)
        let toolkit = Toolkit(dataManager: dataManager)

        try await toolkit.setScriptCommandsAsExecutable()
      } catch {
        Toolkit.raycastDescription()
        Console.shared.writeRed("Error: \(error)")
      }
    }
  }
}
