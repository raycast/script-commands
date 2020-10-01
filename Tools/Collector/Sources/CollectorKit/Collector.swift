// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation
import TSCBasic

public final class Collector {
    private let extensionsPath: String
    private lazy var fileSystem = TSCBasic.localFileSystem
    
    private var extensionsAbsolutePath: AbsolutePath {
        fileSystem.homeDirectory.appending(
            RelativePath(extensionsPath)
        )
    }
    
    public init(path: String) {
        extensionsPath = path
    }
    
    public func start() throws {
        guard fileSystem.exists(extensionsAbsolutePath) else {
            throw Error.extensionsFolderNotFound(extensionsPath)
        }
        
        let blockedList = [".git", "screenshots"]
        let directoryContent = try fileSystem.getDirectoryContents(extensionsAbsolutePath)
        
        var groups: Groups = []
        
        try directoryContent.forEach {
            let path = extensionsAbsolutePath.appending(component: $0)
            
            guard fileSystem.isDirectory(path) && blockedList.contains($0) == false else {
                return
            }
            
            let scriptCommands = try readFiles(from: path)
            let group = Group(
                name: path.basenameWithoutExt.sanitize.capitalized,
                scriptCommands: scriptCommands
            )
            
            groups.append(group)
        }
        
        let data = try groups.toData()
        let extensionsJSONFilePath = extensionsAbsolutePath.appending(component: "raycast-extensions.json")
        
        try fileSystem.writeFileContents(
            extensionsJSONFilePath,
            bytes: ByteString(data.uint8Array)
        )
    }
}

private extension Collector {
    
    func readFiles(from path: AbsolutePath) throws -> ScriptCommands {
        let directoryContent = try fileSystem.getDirectoryContents(path)
        var extensions: ScriptCommands = []
        
        directoryContent.forEach {
            let filePath = path.appending(component: $0)
            
            guard fileSystem.isFile(filePath) else {
                return
            }

            guard let fileContent = readFile(from: filePath) else {
                return
            }
            
            if var object = readMetadata(of: fileContent) {
                if object.packageName == nil {
                    object.packageName = path.basenameWithoutExt.sanitize.capitalized
                }
                
                extensions.append(object)
            }
        }
        
        return extensions
    }
    
    func readFile(from path: AbsolutePath) -> String? {
        guard let byteString = try? fileSystem.readFileContents(path) else {
            return nil
        }
        
        let data = byteString.contents.data
        let content = String(data: data, encoding: .utf8)
        
        return content
    }
    
    func readMetadata(of content: String) -> ScriptCommand? {
        let dictionary = readKeyValue(of: content)
        return dictionary.encodeToStruct()
    }
    
    func readKeyValue(of content: String) -> [String: Any] {
        let regex = "@raycast.(?<key>[A-Za-z]+)\\s(?<value>[A-Za-z0-9 ]+)"
        let results = checkingResults(for: regex, in: content)
        
        var dictionary = [String: Any]()
        
        for result in results {
            let keyRange: NSRange
            let valueRange: NSRange
            
            var key: String?
            var value: String?
            
            if #available(macOS 10.13, *) {
                keyRange = result.range(withName: "key")
                valueRange = result.range(withName: "value")
            }
            else {
                keyRange = result.range(at: 1)
                valueRange = result.range(at: 2)
            }
            
            if keyRange.location != NSNotFound, keyRange.length > 0, let range = Range<String.Index>(keyRange, in: content) {
                key = String(content[range])
            }
            
            if valueRange.location != NSNotFound, valueRange.length > 0, let range = Range<String.Index>(valueRange, in: content) {
                value = String(content[range])
            }
            
            if let key = key, let value = value {
                if let intValue = Int(value) {
                    dictionary[key] = intValue
                }
                else if let boolValue = Bool(value) {
                    dictionary[key] = boolValue
                }
                else {
                    dictionary[key] = value
                }
            }
        }
        
        return dictionary
    }
    
    func checkingResults(for regex: String, in text: String) -> NSTextCheckingResults {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let range = NSRange(text.startIndex...,  in: text)
            
            return regex.matches(in: text, range: range)
        }
        catch let error {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
