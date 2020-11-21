//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

final class Documentation {
  private let fileSystem = TSCBasic.localFileSystem

  private let path: AbsolutePath

  private let markdownFilename: String
  private let jsonFilename: String

  init(path: AbsolutePath, jsonFilename: String, markdownFilename: String) {
    self.path             = path
    self.jsonFilename     = jsonFilename
    self.markdownFilename = markdownFilename
  }

  func generateDocuments(for data: RaycastData) throws {
    try generateMarkdown(for: data)
    try generateJSON(for: data)
  }

}

// MARK: - Private methods

typealias SubGroups = [String: [ScriptCommand]]

private extension Documentation {
  func generateMarkdown(for raycastData: RaycastData) throws {
    let documentFilePath = path.appending(
      component: markdownFilename
    )

    guard let data = markdownData(for: raycastData.groups) else {
      return
    }

    try fileSystem.writeFileContents(
      documentFilePath,
      bytes: ByteString(data.uint8Array)
    )
  }

  func generateJSON(for raycastData: RaycastData) throws {
    let documentFilePath = path.appending(
      component: jsonFilename
    )

    let data = try raycastData.toData()

    try fileSystem.writeFileContents(
      documentFilePath,
      bytes: ByteString(data.uint8Array)
    )
  }

  func markdownData(for groups: Groups) -> Data? {
    var tableOfContents = String.empty
    var contentString = String.empty

    let sortedGroups = groups.sorted()

    sortedGroups.forEach {
      tableOfContents += $0.markdownDescription
    }

    sortedGroups.forEach { group in
      contentString += .newLine + group.sectionTitle

      contentString += renderMarkdown(for: group, leadingPath: "\(group.path)/")
    }

    let markdown = """
        <!-- AUTO GENERATED FILE. DO NOT EDIT. -->
        # Raycast Script Commands

        [Raycast](https://raycast.com) lets you control your tools with a few keystrokes
        and Script Commands makes it possible to execute scripts from anywhere on your desktop.
        They are a great way to speed up every-day tasks such as converting data, opening bookmarks
        or triggering dev workflows.

        This repository contains sample commands and documentation to write your own ones.

        ### Categories
        \(tableOfContents)\(contentString)

        ## Community

        This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast.
        If you have anything cool to show, please send us a pull request. If we screwed something up,
        please report a bug. Join our
        [Slack community](https://www.raycast.com/community)
        to brainstorm ideas with like-minded folks.
        """

    guard let contentData = markdown.data(using: .utf8) else {
      return nil
    }

    return contentData
  }

  func renderMarkdown(for group: Group, headline: Bool = false, leadingPath: String = .empty) -> String {
    var contentString = String.empty

    if group.scriptCommands.count > 0 {
      if headline {
        contentString += .newLine
        contentString += .newLine + "#### \(group.name)"
      }

      contentString += .newLine
      contentString += .newLine + "| Icon | Title | Description | Author |"
      contentString += .newLine + "| ---- | ----- | ----------- | ------ |"

      for var scriptCommand in group.scriptCommands.sorted() {
        scriptCommand.setLeadingPath(leadingPath)
        contentString += scriptCommand.markdownDescription
      }
    }

    if let subGroups = group.subGroups?.sorted() {
      for subGroup in subGroups {
        contentString += renderMarkdown(for: subGroup, headline: true, leadingPath: "\(leadingPath)\(subGroup.path)/")
      }
    }

    return contentString
  }
}
