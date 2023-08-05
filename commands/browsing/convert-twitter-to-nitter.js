#!/usr/bin/env node
// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Convert Twitter to Nitter
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🐔

// Documentation:
// @raycast.description Convert Twitter link to Nitter
// @raycast.author cSharp
// @raycast.authorURL https://github.com/noidwasavailable

// Example Twitter link: https://twitter.com/Cron/status/1644010827647975425
const child_process = require('child_process');
let link = child_process.execSync("pbpaste").toString();

if (!link) {
  console.error('No link provided');
  return;
}

try {
  link = link.replace('twitter.com', 'nitter.net');
  console.log(`Opening ${link}`);
  child_process.execSync(`open "${link}"`);
  return;
} catch (error) {
  console.error('Invalid link provided');
  return;
}
