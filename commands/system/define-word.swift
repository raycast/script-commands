#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Define Word
// @raycast.author Jesse Claven
// @raycast.authorURL https://github.com/jesse-c
// @raycast.description Define a word using the built-in dictionary/dicionaries.
// @raycast.packageName System
// @raycast.mode fullOutput
//
// Optional parameters:
// @raycast.icon 🗣
// @raycast.argument1 { "type": "text", "placeholder": "Word (e.g. isthmus)" }

import Foundation

if CommandLine.argc > 1 {
  let argument = CommandLine.arguments[1].lowercased()

  // https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/DictionaryServicesProgGuide/access/access.html#//apple_ref/doc/uid/TP40006152-CH5-SW3
  let result = DCSCopyTextDefinition(nil, argument as CFString, CFRangeMake(0, argument.count))?.takeRetainedValue() as String?

  print(result ?? "No definition found")
} else {
  print("Must pass 1 word to define") 
}
