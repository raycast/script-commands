#!/bin/bash

# @raycast.title Unicode Superscript
# @raycast.author Adam Zethraeus
# @raycast.authorURL https://github.com/adam-zethraeus
# @raycast.description Convert clipboards text to fake unicode superscript
#
# @raycast.icon 🦸‍♀️
#
# @raycast.mode silent
# @raycast.packageName Conversion
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Text to superscript", "optional": false, "percentEncoded": true}

JXA=$(cat <<-END
function superscript(text) {
  var map = {"0":"⁰","1":"¹","2":"²","3":"³","4":"⁴","5":"⁵","6":"⁶","7":"⁷","8":"⁸","9":"⁹","a":"ᵃ","b":"ᵇ","c":"ᶜ","d":"ᵈ","e":"ᵉ","f":"ᶠ","g":"ᵍ","h":"ʰ","i":"ᶦ","j":"ʲ","k":"ᵏ","l":"ˡ","m":"ᵐ","n":"ⁿ","o":"ᵒ","p":"ᵖ","q":"ᑫ","r":"ʳ","s":"ˢ","t":"ᵗ","u":"ᵘ","v":"ᵛ","w":"ʷ","x":"ˣ","y":"ʸ","z":"ᶻ","A":"ᴬ","B":"ᴮ","C":"ᶜ","D":"ᴰ","E":"ᴱ","F":"ᶠ","G":"ᴳ","H":"ᴴ","I":"ᴵ","J":"ᴶ","K":"ᴷ","L":"ᴸ","M":"ᴹ","N":"ᴺ","O":"ᴼ","P":"ᴾ","Q":"Q","R":"ᴿ","S":"ˢ","T":"ᵀ","U":"ᵁ","V":"ⱽ","W":"ᵂ","X":"ˣ","Y":"ʸ","Z":"ᶻ","+":"⁺","-":"⁻","=":"⁼","(":"⁽",")":"⁾", "q":"ᵠ", "Q":"ᵠ", "?":"ˀ", "!":"ᵎ"};
  var charArray = text.split("");
  for(var i = 0; i < charArray.length; i++) {
    if( map[charArray[i].toLowerCase()] ) {
      charArray[i] = map[charArray[i]];
    }
  }
  text = charArray.join("");
  return text;
}
var app = Application('System Events');  
app.includeStandardAdditions = true;  
var input = decodeURIComponent("$1");
var superscriptOutput = superscript(input);
app.setTheClipboardTo(superscriptOutput);
superscriptOutput + " copied to clipboard";
END
)

echo $JXA | osascript -l JavaScript
