#!/usr/bin/env node

// Required Dependencies:
// - Node.js (https://nodejs.org/en/download/)
// - OpenAI API Key
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Summarize Current Page
// @raycast.mode fullOutput
// @raycast.packageName AI Assistant
// @raycast.icon 📝

// Documentation:
// @raycast.description Get a quick summary of the current browser page (if it's a webpage openly accessible)
// @raycast.author Alexandre Pezzotta
// @raycast.authorURL https://github.com/pezzos

import { exit } from 'process';
import { execSync } from 'child_process';
import { createChatCompletion, createLogger } from './lib/common.js';
import { config } from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import fetch from 'node-fetch';
import { JSDOM } from 'jsdom';

// Initialize paths for ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Initialize logger
const logger = createLogger(__filename);

// Load environment variables from .env file
config({ path: path.join(__dirname, '.env') });

// Validate required environment variables
if (!process.env.OPENAI_API_KEY) {
  logger.error("Error: OPENAI_API_KEY is not set in .env file");
  exit(1);
}

// ANSI color codes
const colors = {
  reset: '\x1b[0m',
  bold: '\x1b[1m',
  blue: '\x1b[34m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  cyan: '\x1b[36m'
};

// Function to get the default browser
function getDefaultBrowser() {
  try {
    const command = `defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers | grep 'LSHandlerRoleAll.*http' -B 1 | grep LSHandlerURLScheme -A 1 | grep LSHandlerRole -A 1 | grep LSHandlerURLScheme -A 2 | grep bundleid | cut -d '"' -f 2`;
    const bundleId = execSync(command).toString().trim();

    // Map bundle IDs to browser names
    const bundleIdToName = {
      'company.thebrowser.Browser': 'Arc',
      'com.google.Chrome': 'Google Chrome',
      'com.apple.Safari': 'Safari',
      'com.microsoft.edgemac': 'Microsoft Edge',
      'com.operasoftware.Opera': 'Opera',
      'com.brave.Browser': 'Brave Browser',
      'org.mozilla.firefox': 'Firefox'
    };

    return bundleIdToName[bundleId] || null;
  } catch (error) {
    logger.info('Could not detect default browser:', error);
    return null;
  }
}

// Function to get the current URL from various browsers
function getCurrentURL() {
  // List of supported browsers with their AppleScript commands
  const browsers = [
    {
      name: 'Arc',
      script: `
        tell application "Arc"
          if (count of windows) > 0 then
            get URL of active tab of front window
          end if
        end tell
      `
    },
    {
      name: 'Google Chrome',
      script: `
        tell application "Google Chrome"
          if (count of windows) > 0 then
            get URL of active tab of front window
          end if
        end tell
      `
    },
    {
      name: 'Safari',
      script: `
        tell application "Safari"
          if (count of windows) > 0 then
            get URL of current tab of front window
          end if
        end tell
      `
    },
    {
      name: 'Microsoft Edge',
      script: `
        tell application "Microsoft Edge"
          if (count of windows) > 0 then
            get URL of active tab of front window
          end if
        end tell
      `
    },
    {
      name: 'Opera',
      script: `
        tell application "Opera"
          if (count of windows) > 0 then
            get URL of active tab of front window
          end if
        end tell
      `
    },
    {
      name: 'Brave Browser',
      script: `
        tell application "Brave Browser"
          if (count of windows) > 0 then
            get URL of active tab of front window
          end if
        end tell
      `
    },
    {
      name: 'Firefox',
      script: `
        tell application "Firefox"
          if (count of windows) > 0 then
            get URL of active tab of front window
          end if
        end tell
      `
    }
  ];

  // Try to get the default browser first
  const defaultBrowser = getDefaultBrowser();
  if (defaultBrowser) {
    logger.info(`Detected default browser: ${defaultBrowser}`);

    // Move default browser to the front of the array
    const defaultBrowserIndex = browsers.findIndex(b => b.name === defaultBrowser);
    if (defaultBrowserIndex !== -1) {
      const [defaultBrowserConfig] = browsers.splice(defaultBrowserIndex, 1);
      browsers.unshift(defaultBrowserConfig);
      logger.info(`Prioritizing ${defaultBrowser} as default browser`);
    }
  }

  // Try each browser until we get a URL
  for (const browser of browsers) {
    try {
      logger.info(`Trying to get URL from ${browser.name}...`);
      const url = execSync(`osascript -e '${browser.script}'`).toString().trim();
      if (url && url !== "") {
        logger.info(`Successfully got URL from ${browser.name}`);
        return url;
      }
    } catch (error) {
      // If the browser is not running or doesn't support the command, continue to next browser
      logger.info(`${browser.name} not available or no active window`);
      continue;
    }
  }

  logger.error("Could not get URL from any supported browser");
  return null;
}

// Function to extract content from a webpage
async function getPageContent(url) {
  try {
    const response = await fetch(url);
    const html = await response.text();
    const dom = new JSDOM(html);
    const document = dom.window.document;

    // Remove script and style elements
    document.querySelectorAll('script, style').forEach(el => el.remove());

    // Get title
    const title = document.querySelector('title')?.textContent || '';

    // Get main content (prioritize main content areas)
    const mainContent = document.querySelector('main, article, #content, .content')?.textContent || document.body.textContent;

    // Clean up the text
    const cleanText = `Title: ${title}\n\nContent: ${mainContent}`
      .replace(/\s+/g, ' ')
      .trim();

    return cleanText;
  } catch (error) {
    logger.error("Error fetching page content:", error);
    return null;
  }
}

// Function to format the output with colors and emojis
function formatOutput(url, summary) {
  return `${colors.blue}${colors.bold}📌 Current Page${colors.reset}
${colors.cyan}${url}${colors.reset}

${colors.green}${colors.bold}📝 Summary${colors.reset}
${colors.yellow}${summary}${colors.reset}`;
}

// Function to summarize the content using OpenAI API
async function summarizeContent(content) {
  const prompt = `Please analyze this webpage content and provide:
1. A concise summary in 2-3 sentences maximum
2. The main topic or category (one word or short phrase)
3. Key highlights (2-3 bullet points maximum), you can use emojis to make it more interesting

Format the response exactly like this:
TOPIC: <topic>
SUMMARY: <your 2-3 sentence summary>
HIGHLIGHTS:
• <first highlight>
• <second highlight>
[• <third highlight if relevant>]

Content: "${content}"`;

  const response = await createChatCompletion(prompt, "gpt-4o-mini", 0.7,
    "You are a webpage summarization assistant. Provide only the requested information in the exact format specified, without any additional text or explanations."
  );

  return response;
}

// Main function to execute the script
async function main() {
  try {
    // Get current URL
    const url = getCurrentURL();
    if (!url) {
      console.log("No active browser tab found or URL couldn't be retrieved");
      exit(1);
    }

    // Get page content
    const content = await getPageContent(url);
    if (!content) {
      console.log("Could not fetch page content");
      exit(1);
    }

    // Generate summary
    const summary = await summarizeContent(content);
    if (summary) {
      console.log(formatOutput(url, summary));
    }

    exit(0);
  } catch (error) {
    logger.error("Fatal error occurred", error);
    exit(1);
  }
}

// Execute the main function
main().catch(error => {
  logger.error("Unhandled error occurred", error);
  exit(1);
});
