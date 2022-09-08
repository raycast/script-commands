#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Clipboard to Markdown
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 📋
// @raycast.packageName Conversions

// Documentation:
// @raycast.description Automatically take the content found in the clipboard and turn it into Markdown
// @raycast.author Alessandra Pereyra
// @raycast.authorURL https://github.com/alessandrapereyra

// Based on the code from
// https://github.com/raycast/script-commands/blob/master/commands/conversions/create-markdown-table.js

const child_process = require("child_process");

function pbpaste() {
  return child_process.execSync("pbpaste").toString();
}

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

function processLine(content) {
  if (
    content.startsWith("* ") ||
    content.startsWith("- ") ||
    content.startsWith("+ ")
  ) {
    return "* " + processContent(content.substring(2));
  }
  return processContent(content);
}

function processLines(content) {
  const lines = content.split("\n");
  const markdownLines = lines.map((line) => {
    return processLine(line);
  });
  return markdownLines.join("\n");
}

function processImageURL(content) {
  return `![Image](${content})`;
}

function processURL(content) {
  return `[${content}](${content})`;
}

function processText(content) {
  return content;
}

function processContent(content) {
  if (content.startsWith("http")) {
    if (content.match(/\.(jpeg|jpg|gif|png|bmp|tiff)$/) != null) {
      return processImageURL(content);
    } else {
      return processURL(content);
    }
  } else {
    return processText(content);
  }
}

function processStoredContent(content) {
  if (content.includes("\n")) {
    return processLines(content);
  } else {
    return processContent(content);
  }
}

const storedClipboardContent = pbpaste();

let markdown = processStoredContent(storedClipboardContent);

pbcopy(markdown);
