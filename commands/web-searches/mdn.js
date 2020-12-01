#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title MDN JS Docs
// @raycast.mode silent
//
// Optional parameters:
// @raycast.packageName Web Searches
// @raycast.icon images/mdn.png
// @raycast.argument1 { "type": "text", "placeholder": "query" }
//
// Documentation:
// @raycast.author Jesse Traynham
// @raycast.description Search Javascript topic on MDN.

const { exec } = require('child_process')
const query = encodeURIComponent(process.argv[2])

exec(`open "https://developer.mozilla.org/en-US/search?topic=js&q=${query}"`)