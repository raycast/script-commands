#!/usr/bin/env node

// Dependencies:
// This script requires the following software to be installed:
// - `node` https://nodejs.org
// - `chrome-cli` https://github.com/prasmussen/chrome-cli
// Install via homebrew: `brew install node chrome-cli`

// This script needs to run JavaScript in your browser, which requires your permission.
// To do so, open Chrome and find the menu bar item:
// View > Developer > Allow JavaScript from Apple Events

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Ask Claude
// @raycast.mode silent
// @raycast.packageName Claude

// Optional parameters:
// @raycast.icon ✨
// @raycast.argument1 { "type": "text", "placeholder": "Prompt"}

// Documentation:
// @raycast.description Open Claude in Chrome browser and submit a prompt
// @raycast.author Nimo Beeren
// @raycast.authorURL https://github.com/nimobeeren

const { execSync } = require("child_process");

const prompt = process.argv[2];

process.env.OUTPUT_FORMAT = "json";

/** Escape a string so that it can be used in JavaScript code when wrapped in double quotes. */
function escapeJsString(str) {
  return str.replaceAll(`\\`, `\\\\`).replaceAll(`"`, `\\"`);
}

/** Escape a string so that it can be used in a shell command when wrapped in single quotes. */
function escapeShellString(str) {
  return str.replaceAll(`'`, `'"'"'`);
}

try {
  execSync("which chrome-cli");
} catch {
  console.error(
    "chrome-cli is required to run this script (https://github.com/prasmussen/chrome-cli)"
  );
  process.exit(1);
}

// Find the Claude tab if one is already open
let tabs = JSON.parse(execSync("chrome-cli list tabs")).tabs;
let claudeTab = tabs.find((tab) => tab.url.startsWith("https://claude.ai/"));

// If there is a Claude tab open, get its info. Otherwise, open Claude in a new
// window.
let claudeTabInfo;
if (claudeTab) {
  // Open a new Claude session in the existing tab and focus it
  execSync(`chrome-cli open 'https://claude.ai/new' -t ${claudeTab.id}`);
  // Get tab info
  claudeTabInfo = JSON.parse(execSync(`chrome-cli info -t ${claudeTab.id}`));
} else {
  // Open a Claude session in a new tab, focus it and return the tab info
  claudeTabInfo = JSON.parse(
    execSync("chrome-cli open 'https://claude.ai/new'")
  );
}

// Wait for the tab to be loaded, then execute the script
let interval = setInterval(() => {
  if (claudeTabInfo.loading) {
    claudeTabInfo = JSON.parse(
      execSync(`chrome-cli info -t ${claudeTabInfo.id}`)
    );
  } else {
    clearInterval(interval);
    executeScript();
  }
}, 100);

function executeScript() {
  const script = async function (prompt) {
    // Wait for prompt element to be on the page
    let promptElement;
    await new Promise((resolve) => {
      let interval = setInterval(() => {
        promptElement = document.querySelector(
          '[aria-label="Write your prompt to Claude"] > div'
        );
        if (promptElement) {
          clearInterval(interval);
          resolve();
        }
      }, 100);
    });

    // Set the prompt
    const p = document.createElement("p");
    p.textContent = prompt;
    promptElement.replaceChildren(p);

    // Wait for submit button to be on the page
    let submitButton;
    await new Promise((resolve) => {
      let interval = setInterval(() => {
        submitButton = document.querySelector('[aria-label="Send Message"]');
        if (submitButton) {
          clearInterval(interval);
          resolve();
        }
      }, 100);
    });

    // Submit the prompt
    submitButton.click();
  };

  const functionString = escapeShellString(script.toString());
  const promptString = escapeShellString(escapeJsString(prompt));

  execSync(
    `chrome-cli execute '(${functionString})("${promptString}")' -t ${claudeTabInfo.id}`
  );
}
