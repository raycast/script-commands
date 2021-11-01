#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Markdown Table
// @raycast.packageName Conversions
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🧱
// @raycast.argument1 { "type": "text", "placeholder": "Columns" }
// @raycast.argument2 { "type": "text", "placeholder": "Rows" }

// Documentation:
// @raycast.description Create a markdown table template
// @raycast.author Ryan Nystrom
// @raycast.authorURL https://github.com/rnystrom

const child_process = require("child_process");

function pbcopy(data) {
  return new Promise(function (resolve, reject) {
    const child = child_process.spawn("pbcopy");

    child.on("error", function (err) {
      reject(err);
    });

    child.on("close", function (err) {
      resolve(data);
    });

    child.stdin.write(data);
    child.stdin.end();
  });
}

let [columns, rows] = process.argv.slice(2);
columns = Math.max(parseInt(columns), 1);
rows = Math.max(parseInt(rows), 1);

let emptyTemplate = "   ";
let headerTemplate = "---";
let rowArr = Array(columns + 1).fill("|");

let lines = [];

// header
lines.push(rowArr.join(emptyTemplate));
// header spacer |---|
lines.push(rowArr.join(headerTemplate));

// rows
for (let i = 0; i < rows; i++) {
  lines.push(rowArr.join(emptyTemplate));
}

pbcopy(lines.join("\n"));
