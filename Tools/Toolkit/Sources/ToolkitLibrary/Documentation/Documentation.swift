//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

final class Documentation {
  private let fileSystem = TSCBasic.localFileSystem

  private let path: AbsolutePath
  private let filename: String

  init(path: AbsolutePath, filename: String) {
    self.path     = path
    self.filename = filename
  }

  func generateDocuments(using groups: Groups) throws {
    try generateMarkdown(using: groups)
    try generateJSON(using: groups)
  }

}

// MARK: - Private methods

typealias SubGroups = [String: [ScriptCommand]]

private extension Documentation {
  func generateMarkdown(using groups: Groups) throws {
    let documentFilePath = path.appending(
      component: filename + ".md"
    )

    guard let data = markdownData(for: groups) else {
      return
    }

    try fileSystem.writeFileContents(
      documentFilePath,
      bytes: ByteString(data.uint8Array)
    )
  }

  func generateJSON(using groups: Groups) throws {
    let documentFilePath = path.appending(
      component: filename + ".json"
    )

    let data = try groups.toData()

    try fileSystem.writeFileContents(
      documentFilePath,
      bytes: ByteString(data.uint8Array)
    )
  }

  func markdownData(for groups: Groups) -> Data? {
    var tableOfContents: String = .empty
    var contentString: String = .empty

    let sortedGroups = groups.sorted()

    sortedGroups.forEach {
      tableOfContents += .newLine + $0.markdownDescription
    }

    sortedGroups.forEach { group in
      contentString += .newLine + group.sectionTitle

      contentString += self.markdown(
        for: subGroups(for: group)
      )
    }

    let markdown = """
        # Raycast Script Commands

        [Raycast](https://raycast.com) lets you control your tools with a few keystrokes
        and Script Commands makes it possible to execute scripts from anywhere on your desktop.
        They are a great way to speed up every-day tasks such as converting data, opening bookmarks
        or triggering dev workflows.

        This repository contains sample commands and documentation to write your own ones.

        ### Content
        \(tableOfContents)\(contentString)

        ## Community

        This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast.
        If you have anything cool to show, please send us a pull request. If we screwed something up,
        please report a bug. Join our
        [Slack community](https://join.slack.com/t/raycastcommunity/shared_invite/zt-hhzj9i4m-D5~HwnTRsJKrcZmVDJ4mkg)
        to brainstorm ideas with like-minded folks.
        """

    guard let contentData = markdown.data(using: .utf8) else {
      return nil
    }

    return contentData
  }
}

// MARK: - SubGroups Private Methods

private extension Documentation {
  func subGroups(for group: Group) -> SubGroups {
    var subGroups: [String: [ScriptCommand]] = [:]

    for var script in group.scriptCommands {

      var packageName = script.packageName ?? .empty
      if packageName == group.name {
        packageName = .empty
      }

      if subGroups[packageName] == nil {
        subGroups[packageName] = []
      }

      script.setGroupPath(for: group)
      subGroups[packageName]?.append(script)
    }

    return subGroups
  }

  func markdown(for subGroups: SubGroups) -> String {
    var contentString = ""

    for subGroup in subGroups.sorted(by: { $0.key < $1.key }) {
      if subGroup.key.isEmpty == false {
        contentString += .newLine
        contentString += .newLine + "#### \(subGroup.key)"
      }

      contentString += .newLine
      contentString += .newLine + "| Icon | Title | Description | Author |"
      contentString += .newLine + "| ---- | ----- | ----------- | ------ |"

      let scripts = subGroup.value.sorted()

      for script in scripts {
        contentString += script.markdownDescription
      }
    }

    return contentString
  }

}
