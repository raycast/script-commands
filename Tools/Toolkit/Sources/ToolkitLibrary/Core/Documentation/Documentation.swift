//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
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

private extension Documentation {
  func generateMarkdown(for raycastData: RaycastData) throws {
    let documentFilePath = path.appending(
      component: markdownFilename
    )

    guard let data = markdownData(for: raycastData) else {
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

  func markdownData(for raycastData: RaycastData) -> Data? {
    let groups = raycastData.groups
    var tableOfContents = String.empty
    var contentString = String.empty

    let sortedGroups = groups.sorted()

    sortedGroups.forEach {
      tableOfContents += $0.markdownDescription
    }

    sortedGroups.forEach { group in
      contentString += .newLine + group.sectionTitle

      contentString += renderMarkdown(for: group)
    }

    let markdown = """
      <!-- AUTO GENERATED FILE. DO NOT EDIT. -->
      \(renderBadges())

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

  func renderMarkdown(for group: Group, headline: Bool = false) -> String {
    var contentString = String.empty

    if group.scriptCommands.isEmpty == false {
      if headline {
        contentString += .newLine
        contentString += .newLine + "#### \(group.name)"
      }

      contentString += .newLine
      contentString += .newLine + "| Icon | Title | Description | Author | Args | Templ | Lang |"
      contentString += .newLine + "| :--: | ----- | ----------- | :----: | :--: | :---: | :--: |"

      for scriptCommand in group.scriptCommands.sorted() {
        contentString += scriptCommand.markdownDescription
      }
    }

    if let subGroups = group.subGroups?.sorted() {
      for subGroup in subGroups {
        contentString += renderMarkdown(
          for: subGroup,
          headline: true
        )
      }
    }

    return contentString
  }

  func renderBadges() -> String {
    let logo = "data:image/png;base64,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"

    let style      = "for-the-badge"
    let labelColor = "202123"
    let dataURL    = "https:%2F%2Fraw.githubusercontent.com%2Fraycast%2Fscript-commands%2Fmaster%2Fcommands%2Fextensions.json"
    let jsonPath   = "$.totalScriptCommands"

    let badges = """
    <div align="center">
      <a href="https://github.com/raycast/script-commands">
        <img alt="GitHub contributors" src="https://img.shields.io/badge/dynamic/json?style=\(style)&color=\(labelColor)&label=Script%20Commands&query=\(jsonPath)&url=\(dataURL)&logo=\(logo)&labelColor=\(labelColor)">
      </a>
      <a href="https://github.com/raycast/script-commands/graphs/contributors">
        <img alt="GitHub contributors" src="https://img.shields.io/github/stars/raycast?style=\(style)">
      </a>
      <a href="https://github.com/raycast/script-commands/stargazers">
        <img alt="GitHub Org's stars" src="https://img.shields.io/github/contributors/raycast/script-commands?style=\(style)">
      </a>
      <a href="https://twitter.com/raycastapp">
        <img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/raycastapp?style=\(style)">
      </a>
    </div>
    """

    return badges
  }
}
