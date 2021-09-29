#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Create Spotify Command
// @raycast.mode silent

// Optional parameters:
// @raycast.icon ./images/spotify-create.png
// @raycast.packageName Spotify
// @raycast.argument1 { "type": "text", "placeholder": "Discover Weekly" }

// Documentation:
// @raycast.description Create Spotify Shortcut Command from the Spotify URL that's in your clipboard
// @raycast.author Nichlas Wærnes Andersen
// @raycast.authorURL https://twitter.com/nichlaswa

import fs from "fs";
import { execSync } from "child_process";

// Get Clipboard contents
const URL = execSync("pbpaste").toString();

// Filter out the information from URL
const code = URL?.split("/")[4].split("?")[0];
const type = URL?.split("/")[3];

console.log(`code: ${code}, type: ${type}`);

const [commandName] = process.argv.slice(2);

// Create a new Spotify script
const scriptContent = `#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ${commandName}
# @raycast.mode silent
# @raycast.packageName Spotify
#
# Optional parameters:
# @raycast.icon ./images/spotify-logo.png
#
# Documentation:
# @raycast.description Play ${commandName} on Spotify
# @raycast.author Nichlas W. Andersen
# @raycast.authorURL https://twitter.com/nichlaswa

property uri: "spotify:${type}:${code}"

tell application "Spotify" to play track uri`;

// Slugify
const slugify = (string) => {
  const a =
    "àáâäæãåāăąçćčđďèéêëēėęěğǵḧîïíīįìłḿñńǹňôöòóœøōõőṕŕřßśšşșťțûüùúūǘůűųẃẍÿýžźż·/_,:;";
  const b =
    "aaaaaaaaaacccddeeeeeeeegghiiiiiilmnnnnoooooooooprrsssssttuuuuuuuuuwxyyzzz------";
  const p = new RegExp(a.split("").join("|"), "g");

  return string
    .toString()
    .toLowerCase()
    .replace(/\s+/g, "-") // Replace spaces with -
    .replace(p, (c) => b.charAt(a.indexOf(c))) // Replace special characters
    .replace(/&/g, "-and-") // Replace & with 'and'
    .replace(/[^\w\-]+/g, "") // Remove all non-word characters
    .replace(/\-\-+/g, "-") // Replace multiple - with single -
    .replace(/^-+/, "") // Trim - from start of text
    .replace(/-+$/, ""); // Trim - from end of text
};

// Write script to disk
if (!/track|album|playlist/.test(type)) {
  console.log("Could not find Spotify URL in clipboard");
} else {
  fs.writeFileSync(
    `./spotify-play-${slugify(commandName)}.applescript`,
    scriptContent
  );
  console.log(`${commandName} is ready`);
}
