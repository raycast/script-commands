//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

extension Toolkit {
  func readKeyValues(of content: String) -> [String: Any] {
    let regex = "@raycast.(?<key>[A-Za-z]+)\\s(?<value>[\\S ]+)"
    let results = RegEx.checkingResults(for: regex, in: content)

    var dictionary: [String: Any] = [:]
    let authors = extractAuthors(from: content, using: results)
    
    if authors.count > 0 {
      dictionary["authors"] = extractAuthors(from: content, using: results)
    }
    
    for result in results {
      let keyValue = readKeyValue(from: result, content: content)
      
      guard keyValue.isAuthorKeys == false else {
        continue
      }
      
      dictionary.merge(keyValue) { $1 }
    }
    
    return dictionary
  }
  
  func extractAuthors(from content: String, using results: NSTextCheckingResults) -> [[String: String]] {
    var authors: [[String: String]] = []
    var currentAuthor: [String: String] = [:]
    
    for result in results {
      let dictionary = readKeyValue(from: result, content: content)

      guard let key = dictionary.keys.first, dictionary.isAuthorKeys else {
        continue
      }
      
      if currentAuthor.keys.count == 2 {
        currentAuthor = [:]
      }
      
      if let value = dictionary[key] as? String {
        currentAuthor[key] = value
      }
      
      if currentAuthor.keys.count == 2 {
        authors.append(currentAuthor)
        currentAuthor = [:]
      }
    }
    
    return authors
  }

// MARK: - Dictionary Extension

fileprivate extension Dictionary where Key == String {
  var isAuthorKeys: Bool {
    typealias Keys = ScriptCommand.Author.InputCodingKeys
    let authorNameKey = Keys.name.rawValue
    let authorURLKey = Keys.url.rawValue
    
    guard let key = keys.first else {
      return false
    }
    
    return key == authorNameKey || key == authorURLKey
  }
}
