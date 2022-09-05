#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Dictionary Lookup
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 📖
// @raycast.packageName Writing
// @raycast.argument1 { "type": "text", "placeholder": "word or phrase" }

// Documentation:
// @raycast.description Directly use macOS Dictionary
// @raycast.author Alessandra Pereyra
// @raycast.authorURL https://github.com/alessandrapereyra

import Cocoa
import CoreServices.DictionaryServices

func translate(_ text: String) -> String? {
    let nsstring = text as NSString
    let cfrange = CFRange(location: 0, length: nsstring.length)

    guard let definition = DCSCopyTextDefinition(nil, nsstring, cfrange) else {
        return nil
    }

    var foundDefinitions = String(definition.takeRetainedValue()).components(separatedBy:  "\n")

    if foundDefinitions.count > 1 {
        foundDefinitions.removeFirst()
        foundDefinitions.removeFirst()
        foundDefinitions.removeLast()
    }

    return foundDefinitions.joined(separator: " • ")
}

let text = CommandLine.arguments[1]
let definition = translate(text) ?? "No definition found for \"\(text)\""
print(definition)
