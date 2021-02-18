#!/usr/bin/env node

// Google Maps search script
//
// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Search Google Maps
// @raycast.mode fullOutput
// @raycast.packageName Raycast Scripts
//
// Optional parameters:
// @raycast.icon 🗺
// @raycast.argument1 { "type": "text", "placeholder": "Location", "optional": true  }
// @raycast.argument2 { "type": "text", "placeholder": "Destination", "optional": true }
//
// Documentation:
// @raycast.description Search google maps, with optional destination field to get directions
// @raycast.author Sam Stephenson
// @raycast.authorURL https://samstephenson.com

const { exec } = require("child_process");

// Use destructuring to grab arguments.
// Use slice to start from position 3.
let [topic, query] = process.argv.slice(2);

// Convert spaces in arguments to pluses
topic = topic.replace(/\s/g, "+");
query = query.replace(/\s/g, "+");

let uri;
if (topic === "") {
  uri = `https://www.google.com/maps`;
} else if (query === "") {
  uri = `https://www.google.com/maps/search/${topic}`;
} else {
  uri = `https://www.google.com/maps/dir/${query}/${topic}`;
}

// Uncomment the exec line below to open this query in your web browser.
// Use double quotes around the uri to avoid processing issues.
exec(`open "${uri}"`);
