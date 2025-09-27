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
// @raycast.title Ask Gemini
// @raycast.mode silent
// @raycast.packageName Gemini

// Optional parameters:
// @raycast.icon ./images/icon-gemini.svg
// @raycast.argument1 { "type": "text", "placeholder": "Selected Text", "optional": true }
// @raycast.argument2 { "type": "text", "placeholder": "Prompt"}

// Documentation:
// @raycast.description Open Gemini in Chrome browser and submit a prompt with optional selected text as context
// @raycast.author Est7
// @raycast.authorURL https://github.com/est7

// @raycast.author Nimo Beeren
// @raycast.authorURL https://github.com/nimobeeren

const { execSync } = require("child_process");

const selectedText = process.argv[2] || ""; // Get the text from "Selected Text" argument, or use an empty string if argument is empty.
const prompt = process.argv[3];

process.env.OUTPUT_FORMAT = "json";

/** Escape a string so that it can be used in JavaScript code when wrapped in double quotes. */
function escapeJsString(str) {
  return str.replaceAll(`\\`, `\\\\`).replaceAll(`"`, `\\"`);
}

/** Escape a string so that it can be used in a shell command when wrapped in single quotes. */
function escapeShellString(str) {
  return str.replaceAll(`'`, `'"'"'`);
}

// used to wait for Chrome to activate.
function sleep(ms) {
  const start = Date.now();
  while (Date.now() - start < ms) {}
}

/**
 * Verifies that all required dependencies are installed.
 * Exits the process with an error message if any dependency is missing.
 */
function checkDependencies() {
  // Check if Google Chrome is installed
  try {
    execSync("osascript -e 'tell application \"Google Chrome\" to get version'" , { stdio: "ignore" });
  } catch {
    try {
      execSync("osascript -e 'tell application \"Chrome\" to get version'" , { stdio: "ignore" });
    } catch {
      console.error("Google Chrome is required to run this script");
      process.exit(1);
    }
  }

  // Check if chrome-cli is installed
  try {
    execSync("which chrome-cli");
  } catch {
    console.error(
      "chrome-cli is required to run this script (https://github.com/prasmussen/chrome-cli)"
    );
    process.exit(1);
  }
}

// Verify all dependencies are installed
checkDependencies();

// Bring Chrome to the foreground first.
try {
  // Try to activate Chrome through AppleScript, supporting different possible application names.
  execSync("osascript -e 'tell application \"Google Chrome\" to activate'", {
    stdio: "ignore",
  });
} catch (e) {
  try {
    // If the first naming method fails, try possible alternatives.
    execSync("osascript -e 'tell application \"Chrome\" to activate'", {
      stdio: "ignore",
    });
  } catch (err) {
    console.error(
      "Unable to activate Chrome browser, continue with other operations",
    );
  }
}

// Give Chrome a little time to make sure it is activated
sleep(300);

// Find the Gemini tab if one is already open
let tabs = JSON.parse(execSync("chrome-cli list tabs")).tabs;
let geminiTab = tabs.find((tab) =>
  tab.url.startsWith("https://gemini.google.com/"),
);

// If there is a Gemini tab open, get its info. Otherwise, open Gemini in a new window.
let geminiTabInfo;
if (geminiTab) {
  // Focus on existing tags, do not refresh the page
  execSync(`chrome-cli activate -t ${geminiTab.id}`);
  // Get tab info
  geminiTabInfo = JSON.parse(execSync(`chrome-cli info -t ${geminiTab.id}`));
} else {
  // Open a Gemini session in a new tab, focus it and return the tab info
  geminiTabInfo = JSON.parse(
    execSync("chrome-cli open 'https://gemini.google.com/app'"),
  );
}

// Wait for the tab to be loaded, then execute the script
let interval = setInterval(() => {
  if (geminiTabInfo.loading) {
    geminiTabInfo = JSON.parse(
      execSync(`chrome-cli info -t ${geminiTabInfo.id}`),
    );
  } else {
    clearInterval(interval);
    executeScript();
  }
}, 100);

function executeScript() {
  const script = async function (selectedText, prompt) {
    // Wait for prompt element to be on the page
    let promptElement;
    await new Promise((resolve) => {
      let interval = setInterval(() => {
        promptElement = document.querySelector(
          'div[aria-label="Enter a prompt here"]',
        );
        if (promptElement) {
          clearInterval(interval);
          resolve();
        }
      }, 100);
    });

    // Prepare the final text
    let finalText = "";
    if (selectedText && selectedText.trim() !== "") {
      finalText += `<file_content>${selectedText}</file_contents>\n\n${prompt}`;
    } else {
      finalText = prompt;
    }

    // Focus the input element first
    promptElement.focus();

    // Check if there's existing content
    const hasExistingContent = promptElement.textContent.trim() !== "";

    // Clear existing content if needed - safely without innerHTML
    if (!hasExistingContent) {
      // If empty, we'll just add our content
      // No need to clear anything
    } else {
      // If we want to append to existing content, add a newline
      // Create a new paragraph for separation
      const selection = window.getSelection();
      const range = document.createRange();

      // Move cursor to the end of existing content
      range.selectNodeContents(promptElement);
      range.collapse(false); // false means collapse to end
      selection.removeAllRanges();
      selection.addRange(range);

      // Insert two newlines to separate content
      document.execCommand("insertText", false, "\n\n");
    }

    // Insert the content using execCommand which is safer than innerHTML
    // Split by newlines and insert with proper paragraph formatting
    const paragraphs = finalText.split("\n");
    paragraphs.forEach((paragraph, index) => {
      if (index > 0) {
        // Insert newline between paragraphs (not before the first one)
        document.execCommand("insertText", false, "\n");
      }

      // Insert the paragraph text
      document.execCommand("insertText", false, paragraph || "\u200B");
    });

    // Trigger input event to notify Gemini of changes
    const inputEvent = new Event("input", { bubbles: true });
    promptElement.dispatchEvent(inputEvent);

    // Ensure cursor is at the end and visible
    const selection = window.getSelection();
    const range = document.createRange();
    range.selectNodeContents(promptElement);
    range.collapse(false); // false means collapse to end
    selection.removeAllRanges();
    selection.addRange(range);

    // Scroll to make cursor visible
    promptElement.scrollTop = promptElement.scrollHeight;

    // Additional scroll after a short delay to ensure visibility
    setTimeout(() => {
      promptElement.scrollTop = promptElement.scrollHeight;
    }, 100);
  };

  const functionString = escapeShellString(script.toString());
  const selectedTextString = escapeShellString(escapeJsString(selectedText));
  const promptString = escapeShellString(escapeJsString(prompt));

  execSync(
    `chrome-cli execute '(${functionString})(\"${selectedTextString}\", \"${promptString}\")' -t ${geminiTabInfo.id}`,
  );
}
