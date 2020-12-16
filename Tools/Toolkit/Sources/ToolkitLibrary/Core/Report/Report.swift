//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

final class Report {
  private lazy var scriptCommands = ScriptCommands()
  private lazy var console        = Console.shared

  private let data: RaycastData
  private let type: Toolkit.ReportType
  
  init(data: RaycastData, type: Toolkit.ReportType) {
    self.data = data
    self.type = type
  }
  
  func showResult() {
    data.groups.sorted().forEach { group in
      filter(
        for: group,
        leadingPath: group.path,
        by: type
      )
    }

    renderReport(
      for: scriptCommands
    )
  }
}

// MARK: - Private methods

private extension Report {
  typealias Title = (value: String, color: TerminalController.Color, bold: Bool)
  typealias Titles = [Title]
  typealias Cell = (title: String, length: Int, color: TerminalController.Color, bold: Bool)
  typealias Cells = [Cell]

  func filter(for group: Group, leadingPath: String = .empty, by type: Toolkit.ReportType) {
    if group.scriptCommands.count > 0 {
      for var scriptCommand in group.scriptCommands.sorted() {
        scriptCommand.configure(leadingPath: leadingPath)
        
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
          leadingPath: "\(leadingPath)/\(subGroup.path)",
          by: type
        )
      }
    }
  }

  func renderReport(for scriptCommands: ScriptCommands) {
    let raycast = "Raycast"
    let cellMargin = 2
    var firstColumn = 0
    var secondColumn = 0
    let thirdColumn = 10
    
    scriptCommands.forEach {
      let author: String = $0.authors?.description ?? raycast

      if author.count >= firstColumn {
        firstColumn = author.count
      }

      if $0.fullPath.count >= secondColumn {
        secondColumn = $0.fullPath.count
      }
    }
    
    let columnLengthList = [firstColumn, secondColumn, thirdColumn]
    
    let titleCells = [
      Title(value: raycast, color: .red, bold: true),
      Title(value: "Script Commands", color: .green, bold: false),
    ]
    
    let descriptionCells = [
      Cell(title: "Author", length: firstColumn, color: .noColor, bold: false),
      Cell(title: "Path", length: secondColumn, color: .noColor, bold: false),
      Cell(title: "Executable", length: thirdColumn, color: .noColor, bold: false)
    ]
    
    let headerMaxWidth = columnLengthList.reduce(0, +) + (descriptionCells.count * cellMargin)
    
    renderDivisor(with: columnLengthList)
    renderHeader(maxWidth: headerMaxWidth, titles: titleCells)
    renderDivisor(with: columnLengthList)
    renderRow(for: descriptionCells)
    renderDivisor(with: columnLengthList)
    
    scriptCommands.forEach {
      let author: String = $0.authors?.description ?? raycast
      
      let executableColor: TerminalController.Color = $0.isExecutable ? .yellow : .red
      
      let rowCells = [
        Cell(title: author, length: firstColumn, color: .green, bold: true),
        Cell(title: $0.fullPath, length: secondColumn, color: .noColor, bold: false),
        Cell(title: String($0.isExecutable), length: thirdColumn, color: executableColor, bold: !$0.isExecutable)
      ]
      
      renderRow(for: rowCells)
    }

    renderDivisor(with: columnLengthList)
    console.write("    Total of", endLine: false)
    console.writeYellow(" \(scriptCommands.count) ", bold: true, endLine: false)
    console.write("script commands")
  }
  
  func renderHeader(maxWidth: Int, titles: Titles) {
    let titleCount = titles.map { $0.value }.joined(separator: " ").count
    
    let titleLength = titleCount % 2 == 0 ? titleCount : titleCount + 1
    let halfMaxWidth = maxWidth / 2
    let halfTitleWidth = titleLength / 2
    
    let leadingOffset = halfMaxWidth - halfTitleWidth
    let titleLeadingMargin = " ".`repeat`(by: leadingOffset)
    
    let trailingOffset = maxWidth - (leadingOffset + titleCount)
    let titleTrailingMargin = " ".`repeat`(by: trailingOffset)
    
    console.write("|", endLine: false)
    console.write(titleLeadingMargin, endLine: false)

    titles.enumerated().forEach { (i, title) in
      if i > 0 {
        console.write(" ", endLine: false)
      }
      
      console.write(
        string: title.value,
        color: title.color,
        bold: title.bold,
        endLine: false
      )
    }
    
    console.write(titleTrailingMargin, endLine: false)
    console.write("|")
  }

  func renderRow(for cells: Cells) {
    console.write("|", endLine: false)
    
    cells.forEach { cell in
      let length = cell.length - cell.title.count
      
      var cellString = String.empty
      cellString += " "
      cellString += cell.title
      cellString += " ".`repeat`(by: length)
      
      console.write(
        string: cellString,
        color: cell.color,
        bold: cell.bold,
        endLine: false
      )
      console.write("|", endLine: false)
    }
    
    console.endLine()
  }
  
  func renderDivisor(with maxWidthList: [Int]) {
    var divisor = "+"
    
    maxWidthList.forEach { maxWidth in
      divisor += "-".`repeat`(by: maxWidth + 1)
      divisor += "+"
    }
    
    console.write(divisor, endLine: true)
  }
}

// MARK: - Extension for Array<Author>

fileprivate extension Array where Element == ScriptCommand.Author {
  /// Return the name of the author or in case of multiple authors, just "Multiple"
  var description: String {
    var author = String.empty

    if count == 1 {
      author = self[0].name ?? "Raycast"
    }
    else if count > 1 {
      author = "Multiple"
    }

    return author
  }
}
