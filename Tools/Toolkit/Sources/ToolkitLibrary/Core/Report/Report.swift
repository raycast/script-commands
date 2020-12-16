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
    
    print(
      renderReport(for: scriptCommands)
    )
  }
}

// MARK: - Private methods

private extension Report {
  typealias Cell = (title: String, length: Int)
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

  func renderReport(for scriptCommands: ScriptCommands) -> String {
    Toolkit.raycastDescription()
    
    var firstColumn = 0
    var secondColumn = 0
    let thirdColumn = 10
    
    scriptCommands.forEach {
      let author: String = $0.authors?.description ?? "Raycast"

      if author.count >= firstColumn {
        firstColumn = author.count
      }

      if $0.fullPath.count >= secondColumn {
        secondColumn = $0.fullPath.count
      }
    }
    
    let columnLengthList = [firstColumn, secondColumn, thirdColumn]
    
    var contentString = String.empty
    
    let titleCells = [
      Cell(title: "Author", length: firstColumn),
      Cell(title: "Path", length: secondColumn),
      Cell(title: "Executable", length: thirdColumn),
    ]
    
    contentString += renderDivisor(with: columnLengthList)
    contentString += .newLine
    contentString += renderRow(for: titleCells)
    contentString += .newLine
    contentString += renderDivisor(with: columnLengthList)
    
    scriptCommands.forEach {
      let author: String = $0.authors?.description ?? "Raycast"
      
      let rowCells = [
        Cell(title: author, length: firstColumn),
        Cell(title: $0.fullPath, length: secondColumn),
        Cell(title: String($0.isExecutable), length: thirdColumn),
      ]
      
      contentString += .newLine
      contentString += renderRow(for: rowCells)
    }
    
    contentString += .newLine
    contentString += renderDivisor(with: columnLengthList)
    
    return contentString
  }
  
  func renderRow(for cells: Cells) -> String {
    var content = "|"
    
    cells.forEach { cell in
      let length = cell.length - cell.title.count
      
      content += " "
      content += cell.title
      content += " ".`repeat`(by: length)
      content += "|"
    }
    
    return content
  }
  
  func renderDivisor(with maxWidthList: [Int]) -> String {
    var divisor = "+"
    
    maxWidthList.forEach { maxWidth in
      divisor += "-".`repeat`(by: maxWidth + 1)
      divisor += "+"
    }
    
    return divisor
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
