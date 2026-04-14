//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

extension Toolkit {
  public func generateDocumentation(outputJSONFilename: String, outputMarkdownFilename: String) async throws {
    await dataManager.loadContent()

    let content = try await readFolderContent(
      path: dataManager.extensionsPath,
      ignoreFilesInDir: true,
    )

    await dataManager.setGroups(content.subGroups)

    let documentation = Documentation(
      path: dataManager.extensionsPath,
      jsonFilename: outputJSONFilename,
      markdownFilename: outputMarkdownFilename,
    )

    let data = await dataManager.data
    try documentation.generateDocuments(for: data)
  }
}
