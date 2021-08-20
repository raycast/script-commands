#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Json Stringify Text
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon 💻
// @raycast.packageName Developer Utilities

// Documentation:
// @raycast.description Get JSON-formatted text
// @raycast.author Senthil Prabhu

const child_process = require("child_process");
const fs = require("fs");

// Function to read the output of pbpaste command
function pbpaste() {
  return new Promise((resolve, reject) => {
    const child = child_process.spawn('pbpaste');

    // listen on child process stdout
    let response = "";
    child.stdout.on("data", (chunk) => {
        response += chunk;
    });

    child.on("close", (code) => {
        if (code != 0) {
            reject();
        } else {
            resolve(response);
        }
    });
  });
};

// Function to copy data to clipboard
function pbcopy(data) {
  return new Promise(function(resolve, reject) {
    const child = child_process.spawn('pbcopy');

    child.on('error', function(err) {
      reject(err);
    });

    child.on('close', function(err) {
      resolve(data);
    });

    child.stdin.write(data);
    child.stdin.end();
  });
};

// Stringify the text from clipboard and copy back to it
pbpaste()
.then(function(result) {
  return JSON.stringify(result);
})
.then(function(string) {
  return pbcopy(string);
})
.then(function(string) {
  console.log(string);
}).catch(function(e) {
  console.error(new Error('Could not stringify text'));
  console.error(e);
});
