//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

final class Report {
  private lazy var scriptCommands = ScriptCommands()
  private let console: Console

  private let data: RaycastData
  private let type: Toolkit.ReportType

  init(data: RaycastData, type: Toolkit.ReportType, noColor: Bool) {
    self.console = Console(
      noColor: noColor
    )

    self.data = data
    self.type = type
  }

  func showResult() {
    data.groups.sorted().forEach { group in
      filter(
        for: group,
        by: type
      )
    }

    renderReport(
      for: scriptCommands
    )
  }
}

// MARK: - Signs
extension Report {
  enum Divider {
    static let pipe = "|"
    static let plus = "+"
    static let minus = "-"
    static let space = " "
  }
}

// MARK: - Private methods

private extension Report {
  typealias Title = (value: String, color: TerminalController.Color, bold: Bool)
  typealias Titles = [Title]
  typealias Cell = (title: String, length: Int, color: TerminalController.Color, bold: Bool)
  typealias Cells = [Cell]

  func filter(for group: Group, by type: Toolkit.ReportType) {
    if group.scriptCommands.isEmpty == false {
      for scriptCommand in group.scriptCommands.sorted() {
        switch (type, scriptCommand.isExecutable) {
        case (.executable, true):
          self.scriptCommands.append(scriptCommand)
        case (.nonExecutable, false):
          self.scriptCommands.append(scriptCommand)
        case (.allScripts, _):
          self.scriptCommands.append(scriptCommand)
        default:
          break
        }
      }
    }

    if let subGroups = group.subGroups?.sorted() {
      for subGroup in subGroups {
        filter(
          for: subGroup,
          by: type
        )
      }
    }
  }

  func renderReport(for scriptCommands: ScriptCommands) {
    let raycast = "Raycast"
    let cellMargin = 2
    var firstColumnLength = 0
    var secondColumnLength = 0
    let thirdColumnLength = 10

    scriptCommands.forEach {
      let author: String = $0.authors?.description ?? raycast

      if author.count >= firstColumnLength {
        firstColumnLength = author.count
      }

      if $0.fullPath.count >= secondColumnLength {
        secondColumnLength = $0.fullPath.count
      }
    }

    let columnsLength = [firstColumnLength, secondColumnLength, thirdColumnLength]

    let titleCells = [
      Title(value: raycast, color: .red, bold: true),
      Title(value: "Script Commands", color: .green, bold: true),
    ]

    let descriptionCells = [
      Cell(title: "Author", length: firstColumnLength, color: .noColor, bold: false),
      Cell(title: "Path", length: secondColumnLength, color: .noColor, bold: false),
      Cell(title: "Executable", length: thirdColumnLength, color: .noColor, bold: false),
    ]

    let headerWidth = columnsLength.reduce(0, +) + (descriptionCells.count * cellMargin)

    renderDivider(with: columnsLength)
    renderHeader(with: headerWidth, titles: titleCells)
    renderDivider(with: columnsLength)
    renderRow(for: descriptionCells)
    renderDivider(with: columnsLength)

    scriptCommands.forEach {
      let author = $0.authors?.description ?? raycast

      let executableColor: TerminalController.Color = $0.isExecutable ? .cyan : .yellow

      let rowCells = [
        Cell(title: author, length: firstColumnLength, color: .green, bold: true),
        Cell(title: $0.fullPath, length: secondColumnLength, color: .noColor, bold: false),
        Cell(title: String($0.isExecutable), length: thirdColumnLength, color: executableColor, bold: !$0.isExecutable),
      ]

      renderRow(for: rowCells)
    }

    renderDivider(with: columnsLength)
    console.write("  Total of", endLine: false)
    console.write(string: " \(scriptCommands.count) ", color: .cyan, bold: true, endLine: false)
    console.write("script commands")
  }

  func renderHeader(with maxWidth: Int, titles: Titles) {
    let titleCount = titles.map { $0.value }.joined(separator: " ").count

    let titleLength = titleCount % 2 == 0 ? titleCount : titleCount + 1
    let halfMaxWidth = maxWidth / 2
    let halfTitleWidth = titleLength / 2

    let leadingOffset = halfMaxWidth - halfTitleWidth
    let titleLeadingMargin = Divider.space.`repeat`(by: leadingOffset)

    let trailingOffset = maxWidth - (leadingOffset + titleCount)
    let titleTrailingMargin = Divider.space.`repeat`(by: trailingOffset)

    console.write(Divider.pipe, endLine: false)
    console.write(titleLeadingMargin, endLine: false)

    titles.enumerated().forEach { (i, title) in
      if i > 0 {
        console.write(Divider.space, endLine: false)
      }

      console.write(
        string: title.value,
        color: title.color,
        bold: title.bold,
        endLine: false
      )
    }

    console.write(titleTrailingMargin, endLine: false)
    console.write(Divider.pipe)
  }

  func renderRow(for cells: Cells) {
    console.write(Divider.pipe, endLine: false)

    cells.forEach { cell in
      let length = cell.length - cell.title.count

      var cellString = String.empty
      cellString += Divider.space
      cellString += cell.title
      cellString += Divider.space.`repeat`(by: length)

      console.write(
        string: cellString,
        color: cell.color,
        bold: cell.bold,
        endLine: false
      )
      console.write(Divider.pipe, endLine: false)
    }

    console.endLine()
  }

  func renderDivider(with maxWidthList: [Int]) {
    var divisor = Divider.plus

    maxWidthList.forEach { maxWidth in
      divisor += Divider.minus.`repeat`(by: maxWidth + 1)
      divisor += Divider.plus
    }

    console.write(divisor, endLine: true)
  }
}

// MARK: - Extension for Array<Author>

private extension Array where Element == ScriptCommand.Author {
  /// Return the name of the author or in case of multiple authors, just "Multiple"
  var description: String {
    var author = String.empty

    if count == 1 {
      author = self[0].name ?? "Raycast"
    } else if count > 1 {
      author = "Multiple"
    }

    return author
  }
}
