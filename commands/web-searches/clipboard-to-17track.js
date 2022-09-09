#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Clipboard to 17TRACK
// @raycast.mode silent
// @raycast.packageName Web Searches

// Optional parameters:
// @raycast.icon 🚚

// Documentation:
// @raycast.description Open 17TRACK with the tracking code found in the clipboard
// @raycast.author Alessandra Pereyra
// @raycast.authorURL https://github.com/alessandrapereyra

const child_process = require("child_process");
const trackingCode = child_process.execSync("pbpaste").toString();

const url = `https://t.17track.net/en#nums=${trackingCode}`;
child_process.execSync(`open "${url}"`);
