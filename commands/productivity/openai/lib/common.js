'use strict';

/** @type {import('node')} */

import OpenAI from "openai";
import { execSync } from "child_process";
import dotenv from "dotenv";
import fs from 'fs';
import path from 'path';
// import { fileURLToPath } from 'url';

// Initialize environment variables
dotenv.config();

// Logging utility
export const createLogger = (scriptPath) => {
  const scriptDir = path.dirname(scriptPath);
  const scriptName = path.basename(scriptPath, '.js');
  const logFile = path.join(scriptDir, `${scriptName}.log`);

  // Check if logging is enabled
  const isLoggingEnabled = process.env.LOGS === 'true';

  return {
    info: (message) => {
      if (isLoggingEnabled) {
        const timestamp = new Date().toISOString();
        fs.appendFileSync(logFile, `[${timestamp}] INFO: ${message}\n`);
      }
    },
    warn: (message) => {
      if (isLoggingEnabled) {
        const timestamp = new Date().toISOString();
        fs.appendFileSync(logFile, `[${timestamp}] WARN: ${message}\n`);
      }
    },
    error: (message, error) => {
      if (isLoggingEnabled) {
        const timestamp = new Date().toISOString();
        const errorDetails = error ? `\nStack: ${error.stack}` : '';
        fs.appendFileSync(logFile, `[${timestamp}] ERROR: ${message}${errorDetails}\n`);
      }
    }
  };
};

// Create and export OpenAI instance
export const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

// Common clipboard functions
const getSelectedText = (logger) => {
  let originalClipboard = '';
  try {
    // Store the current clipboard content
    originalClipboard = execSync('pbpaste').toString();

    // Copy the selected text to clipboard using a more robust AppleScript
    const copyScript = `
      tell application "System Events"
        -- Get the frontmost application
        set frontApp to first application process whose frontmost is true
        set frontAppName to name of frontApp

        log "Active application: " & frontAppName

        -- Send copy command
        keystroke "c" using {command down}
        delay 0.3

        -- Get clipboard content
        do shell script "pbpaste"
      end tell
    `;

    const selectedText = execSync(`osascript -e '${copyScript}'`).toString();

    // Compare with original clipboard
    if (selectedText === originalClipboard) {
      logger.warn("Warning: Clipboard content hasn't changed. No text might be selected.");
      throw new Error('No text was selected (clipboard content unchanged)');
    }

    // Clean and validate the result
    const cleanText = selectedText.trim();
    if (!cleanText) {
      throw new Error('No text selected (empty selection)');
    }

    return cleanText;
  } catch (error) {
    logger.error('Error getting selected text:', error);
    throw error;
  } finally {
    // Restore original clipboard content
    try {
      execSync(`echo "${originalClipboard}" | pbcopy`);
    } catch (error) {
      logger.warn("Warning: Could not restore original clipboard content");
    }
  }
};

const pasteText = (text, logger) => {
  try {
    const cleanText = text
      .replace(/^["']|["']$/g, '')
      .replace(/\n*Translation:.*$/gs, '')
      .trim();

    if (!cleanText) {
      throw new Error('No text to paste');
    }

    // Escape special characters for AppleScript
    // Replace standard apostrophe with right single quotation mark (') which AppleScript treats as literal
    // Also escape other special characters that might cause issues
    const escapedText = cleanText
      .replace(/'/g, '\u2019') // Replace standard apostrophe with right single quotation mark
      .replace(/"/g, '\\"') // Escape double quotes
      .replace(/\\/g, '\\\\') // Escape backslashes
      .replace(/\n/g, '\\n') // Escape newlines
      .replace(/\r/g, '\\r') // Escape carriage returns
      .replace(/\t/g, '\\t'); // Escape tabs

    // Use quoted form of text in AppleScript to handle special characters better
    const script = `
      set theText to "${escapedText}"
      set the clipboard to theText
      tell application "System Events"
        keystroke "v" using {command down}
      end tell
    `;

    execSync(`osascript -e '${script}'`);
    return true;
  } catch (error) {
    logger.error('Error pasting text:', error);
    throw error;
  }
};

// Improved OpenAI function with retry logic and timeout
const createChatCompletion = async (prompt, model = "gpt-3.5-turbo", maxRetries = 2, systemPrompt = "You are a helpful assistant.") => {
  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 30000);

      const chatCompletion = await openai.chat.completions.create({
        messages: [
          {
            role: "system",
            content: systemPrompt
          },
          {
            role: "user",
            content: prompt
          }
        ],
        model,
        temperature: 0.3,
        max_tokens: 1000,
        presence_penalty: -0.5,
      }, {
        signal: controller.signal
      });

      clearTimeout(timeoutId);

      if (!chatCompletion?.choices?.[0]?.message?.content) {
        throw new Error('Invalid response from OpenAI API');
      }

      return chatCompletion.choices[0].message.content.trim();
    } catch (error) {
      if (attempt === maxRetries) throw error;
      await new Promise(resolve => setTimeout(resolve, 1000 * Math.pow(2, attempt)));
    }
  }
};

// Add caching for frequently translated content
const translationCache = new Map();
const getCachedTranslation = (text, targetLang) => {
  const cacheKey = `${text}_${targetLang}`;
  return translationCache.get(cacheKey);
};

const setCachedTranslation = (text, targetLang, translation) => {
  const cacheKey = `${text}_${targetLang}`;
  translationCache.set(cacheKey, translation);
};

// Export all functions
export {
  getSelectedText,
  pasteText,
  createChatCompletion,
  getCachedTranslation,
  setCachedTranslation
};
