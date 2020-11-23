#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Search Script Command
// @raycast.mode fullOutput
//
// Optional parameters:
// @raycast.author Thiago Holanda
// @raycast.authorURL https://twitter.com/tholanda
// @raycast.icon 🔎
// @raycast.packageName Searches
// @raycast.argument1 { "type": "text", "placeholder": "Query" }

import Foundation

// MARK: - Typealiases

typealias Groups = [Group]
typealias ScriptCommands = [ScriptCommand]

// MARK: - Models

struct RaycastData: Codable {
  var updatedAt = Date()
  var groups = Groups()
}
struct Group: Codable {
  let name: String
  let path: String
  var scriptCommands: ScriptCommands = []
  var subGroups: Groups?
}
struct ScriptCommand: Codable {
  let schemaVersion: Int
  let title: String
  var filename: String
  let mode: Mode?
  var packageName: String?
  let icon: String?
  let authors: [Author]?
  let details: String?
  let currentDirectoryPath: String?
  let needsConfirmation: Bool?
  let refreshTime: String?
  
  private(set) var leadingPath: String = ""
  
  private enum CodingKeys: String, CodingKey {
    case schemaVersion
    case title
    case filename
    case mode
    case packageName
    case icon
    case authors
    case details = "description"
    case currentDirectoryPath
    case needsConfirmation
    case refreshTime
  }
  
  mutating func setLeadingPath(_ value: String) {
    self.leadingPath = value
  }
}
extension ScriptCommand {
  typealias Authors = [Author]
  
  struct Author: Codable {
    let name: String?
    let url: String?
  }
}
extension ScriptCommand {
  enum Mode: String, Codable {
    case fullOutput
    case compact
    case silent
    case inline
  }
}

// MARK: - Extensions

extension ScriptCommand {
  func contains(_ query: String) -> Bool {
    var description: String = .empty
    
    if let details = self.details {
      description = details
    }
    
    return title.lowercased().contains(query)
      || filename.lowercased().contains(query)
      || description.lowercased().contains(query)
  }
}
extension ScriptCommand: Comparable {
  static func < (lhs: ScriptCommand, rhs: ScriptCommand) -> Bool {
    lhs.title < rhs.title
  }
  
  static func == (lhs: ScriptCommand, rhs: ScriptCommand) -> Bool {
    lhs.title == rhs.title
  }
}
extension Group: Comparable {
  static func < (lhs: Group, rhs: Group) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: Group, rhs: Group) -> Bool {
    lhs.name == rhs.name
  }
}
extension String {
  static var newLine = "\n"
  static var empty = ""
  
  var trimmedText: String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

// MARK: - Store

final class ScriptCommandsStore {
  enum StoreError: Error {
    case emptyData
  }
  
  private var scriptCommands: ScriptCommands = []
  
  private let extensionsURL = URL(string: "https://raw.githubusercontent.com/raycast/script-commands/master/commands/extensions.json")
  
  private lazy var separator: String = {
    var separator = ""
    for i in 0...106 {
      separator += "-"
    }
    
    return separator
  }()
  
  private func githubURL(for path: String) -> String {
    "https://github.com/raycast/script-commands/blob/master/commands/\(path)"
  }
  
  private func loadData() throws -> RaycastData {
    let urlSession = URLSession.shared
    var data: Data?
    
    let semaphore = DispatchSemaphore(value: 0)
    
    guard let url = extensionsURL else {
      throw URLError(.badURL)
    }
    
    let task = urlSession.dataTask(with: url) { responseData, response, error in
      data = responseData
      
      semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
    
    guard let unwrappedData = data else {
      throw StoreError.emptyData
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    let raycastData = try decoder.decode(RaycastData.self, from: unwrappedData)
    
    return raycastData
  }
  
  func searchCommand(using query: String) {
    do {
      let data = try loadData()
      search(for: query, in: data.groups)

      if scriptCommands.count > 0 {
        print(
          renderOutput(
            for: scriptCommands
          )
        )
      }
      else {
        print("No script command found with '\(query)'")
      }
    }
    catch {
      exit(1)
    }
  }
  
  private func search(for query: String, in groups: Groups) {
    for group in groups {
      search(
        for: query, 
        in: group, 
        leadingPath: group.path
      )
    }
    
    scriptCommands = scriptCommands.sorted()
  }
  
  private func search(for query: String, in group: Group, leadingPath: String = "") {
    if group.scriptCommands.count > 0 {
      for var scriptCommand in group.scriptCommands {
        
        if scriptCommand.contains(query) {
          scriptCommand.setLeadingPath(
            "\(leadingPath)/\(scriptCommand.filename)"
          )
          
          self.scriptCommands.append(scriptCommand)
        }
      }
    }
    
    if let subGroups = group.subGroups {
      for subGroup in subGroups {
        search(
          for: query, 
          in: subGroup, 
          leadingPath: "\(leadingPath)/\(subGroup.path)"
        )
      }
    }
  }
  
  private func renderOutput(for scriptCommands: ScriptCommands) -> String {
    var contentString = String.empty
    
    for scriptCommand in scriptCommands {
      var description: String = .empty
      
      if let details = scriptCommand.details {
        description = ": \(details)"
      }
      
      if contentString.count > 0 {
        contentString += .newLine + .newLine
        contentString += separator
        contentString += .newLine + .newLine
      }
      
      contentString += scriptCommand.title
      contentString += description
      contentString += .newLine
      contentString += githubURL(for: scriptCommand.leadingPath)
    }
    
    return contentString
  }
}

if CommandLine.arguments.count > 1 {
  let query = CommandLine.arguments[1].lowercased().trimmedText
  
  if query.isEmpty {
    print("Query must not be empty")
  }
  else {
    let store = ScriptCommandsStore()
    store.searchCommand(using: query)
  }
}
