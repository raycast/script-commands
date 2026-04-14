//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Toolkit {
  public func setScriptCommandsAsExecutable() async throws {
    let content = try await readFolderContent(
      path: dataManager.extensionsPath,
      ignoreFilesInDir: true
    )

    var scriptCommands = ScriptCommands()

    content.subGroups.forEach { group in
      filter(for: group, scriptCommands: &scriptCommands)
    }

    let rawCount     = scriptCommands.count
    var newModeCount = 0

    for scriptCommand in scriptCommands.sorted() {
      let filePath = dataManager.extensionsPath
        .appendingPathComponent(scriptCommand.fullPath)

      do {
        try filePath.setExecutable()
        newModeCount += 1
      } catch {
        continue
      }
    }

    Toolkit.raycastDescription()

    if newModeCount > 0 {
      Console.shared.write("Result:", endLine: false)
      Console.shared.writeYellow(" \(newModeCount) ", bold: true, endLine: false)
      Console.shared.write("of", endLine: false)
      Console.shared.writeGreen(" \(rawCount) ", bold: true, endLine: false)
      Console.shared.write("Script Commands was set as \"executable\".")
    } else {
      Console.shared.write("✅ Nothing to be done.")
    }
  }
}

private extension Toolkit {
  func filter(for group: Group, scriptCommands: inout ScriptCommands) {
    for scriptCommand in group.scriptCommands where !scriptCommand.isExecutable {
      scriptCommands.append(scriptCommand)
    }

    if let subGroups = group.subGroups {
      for subGroup in subGroups {
        filter(for: subGroup, scriptCommands: &scriptCommands)
      }
    }
  }
}
