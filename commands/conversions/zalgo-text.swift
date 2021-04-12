#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Zalgo Text
// @raycast.mode silent
// @raycast.author Adam Zethraeus
// @raycast.authorURL https://github.com/adam-zethraeus
// @raycast.packageName Conversions
// @raycast.icon 👹
// @raycast.argument1 { "type": "text", "placeholder": "Text to Z̶̶͚̯͗a̩̞͜͜l̫͕ͬͨ̿g͈̫͂ͤ͆͢o̠͚̞ͥ" }
// @raycast.argument2 { "type": "text", "optional": true, "placeholder": "Intensity=5" }

// Documentation:
// @raycast.description Converts text to z̫̫̐a̳ͩl̓͂̀ͅg͔̚o̷̦̣͢ t̳͆ḛ̊͟ẍ̮̝́t̵̔ͯ͝

import Cocoa

// zalgo function credit mattt @ https://gist.github.com/mattt/b46ab5027f1ee6ab1a45583a41240033
func zalgo(_ string: String, intensity: Int = 5) -> String {
    let combiningDiacriticMarks = 0x0300...0x036f
    let latinAlphabetUppercase = 0x0041...0x005a
    let latinAlphabetLowercase = 0x0061...0x007a
 
    var output: [UnicodeScalar] = []
    for scalar in string.unicodeScalars {
        output.append(scalar)
        guard (latinAlphabetUppercase).contains(numericCast(scalar.value)) ||
              (latinAlphabetLowercase).contains(numericCast(scalar.value))
        else {
            continue
        }

        for _ in 0...(Int.random(in: 1...intensity)) {
            let randomScalarValue = Int.random(in: combiningDiacriticMarks)
            output.append(Unicode.Scalar(randomScalarValue)!)
        }
    }

    return String(String.UnicodeScalarView(output))
}

NSPasteboard.general.clearContents()
let text = CommandLine.arguments[1]
let intensityString = CommandLine.arguments[2]
let intensity = Int(intensityString) ?? 5
let zalgoText = zalgo(text, intensity: intensity)
NSPasteboard.general.setString(zalgoText, forType: .string)
print("\(zalgoText) copied to clipboard")
