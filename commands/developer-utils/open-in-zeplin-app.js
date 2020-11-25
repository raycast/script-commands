#!/usr/bin/env node

// Dependency: This script requires `Node.js` installed: https://nodejs.org/
// Install via homebrew: `brew install node`

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Open in Zeplin
// @raycast.mode compact

// Optional parameters:
// @raycast.icon https://zeplin.io/img/favicon/32x32.png
// @raycast.argument1 { "type": "text", "placeholder": "Zeplin web link" }

// Documentation:
// @raycast.author Sasivarnan R
// @raycast.authorURL https://github.com/sasivarnan
// @raycast.description Open the Zeplin URL using Zeplin app instead of the browser

const { get } = require("https");
const { exec } = require("child_process");

const ERROR_MESSAGE = "❌ Enter a valid Zeplin URL";

const SUCCESS_MESSAGE = "📭 Opening link with Zeplin";

const getZeplinUniversalLink = (pathname) => {
  const paths = pathname.split("/");
  let zeplinAppUrl = "zpl://";

  if (paths[4]) {
    // Screen URL - /project/<pid>/screen/<sid>
    zeplinAppUrl += `screen?pid=${paths[2]}&sid=${paths[4]}`;
  } else {
    // Project URL - /project/<pid>/dashboard
    zeplinAppUrl += `project?pid=${paths[2]}`;
  }

  return zeplinAppUrl;
};

const getExpandedZeplinURL = (url) => {
  try {
    get(url, (res) => {
      if (res.statusCode === 302) {
        // redirected to expanded URL
        const pathname = new URL(res.headers.location).pathname;
        const universalLink = getZeplinUniversalLink(pathname);
        openUniversalZeplinLink(universalLink);
      } else {
        throw new Error("Invalid Link");
      }
    });
  } catch (error) {
    console.error(error);
    console.log(ERROR_MESSAGE);
  }
};

const openUniversalZeplinLink = (zeplinAppUrl) => {
  const command = `open "${zeplinAppUrl}"`;

  console.log(SUCCESS_MESSAGE);

  exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }
  });
};

// NORMALIZE ARGV FOR BOTH RAYCAST AND COMMAND LINE
let argv = process.argv.slice(2).join(" ").split(" ");

const url = argv[0] || "";

if (url.startsWith("zpl://")) {
  // Universal Link
  openUniversalZeplinLink(url);
} else if (url.indexOf("zpl.io") > -1) {
  // Short Link
  getExpandedZeplinURL(url);
} else if (url.indexOf("app.zeplin.io") > -1) {
  // Expanded Link
  const universalLink = getZeplinUniversalLink(url);
  openUniversalZeplinLink(universalLink);
} else {
  // Invalid Link
  console.log(ERROR_MESSAGE);
}
