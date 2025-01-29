#!/usr/bin/env node

// Required Dependencies:
// - Node.js (https://nodejs.org/en/download/)
// - OpenAI API Key
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Translate Selected Text
// @raycast.mode silent
// @raycast.packageName AI Assistant
// @raycast.icon 🌐

// Documentation:
// @raycast.description Instantly translate selected text between configured languages using OpenAI's GPT model.
// @raycast.author Alexandre Pezzotta
// @raycast.authorURL https://github.com/pezzos
//
// Features:
// - Automatic language detection between configured languages
// - Maintains original formatting and punctuation
// - Preserves technical terms and special characters
// - Optional text improvement (grammar and spelling)
// - Translation caching for improved performance
//
// Configuration:
// Create a .env file in the same directory with the following variables:
// ```
// OPENAI_API_KEY=sk-your-api-key    # Required: Your OpenAI API key
// LANGS=fr,en                        # Required: Comma-separated list of languages to translate between, two languages are required
// FIX_TEXT=true                      # Optional: Set to "true" to improve translation quality
// ```
//
// Usage:
// 1. Select text in any application
// 2. Trigger the command through Raycast
// 3. The selected text will be replaced with its translation
//
// Note: Translation quality depends on the GPT model used and the complexity of the text.
// For optimal results, ensure your text is clear and well-formatted.

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/
//
// Configuration:
// This script requires a .env file in the same directory with the following variables:
// - OPENAI_API_KEY: Your OpenAI API key (required)
// - LANGS: Comma-separated list of languages to translate between (e.g., "fr,en")
// - FIX_TEXT: Set to "true" to improve translation quality
//
// Example .env file:
// OPENAI_API_KEY=sk-your-api-key
// LANGS=fr,en
// FIX_TEXT=true

import { exit } from 'process';
import { getSelectedText, pasteText, createChatCompletion, getCachedTranslation, setCachedTranslation, createLogger } from './lib/common.js';
import { config } from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

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

if (!process.env.LANGS) {
  logger.error("Error: LANGS is not set in .env file. Format should be: LANGS=lang1,lang2");
  exit(1);
}

// Function to translate the text using OpenAI Text API
async function translate(text) {
  const languages = process.env.LANGS.split(",");

  // Check cache first
  const cachedResult = getCachedTranslation(text, languages.join('_'));
  if (cachedResult) {
    logger.info("Using cached translation");
    return cachedResult;
  }

  // Enhanced prompt for better accuracy and optional text fixing
  const prompt = `Translate this text from one of these languages [${languages}] to the other language:
"${text}"

Rules:
- Keep formatting and punctuation
- Preserve special characters and technical terms
- Match the original tone${process.env.FIX_TEXT === "true" ? '\n- Fix any grammar or spelling issues' : ''}`;

  const translation = await createChatCompletion(prompt, "gpt-4o-mini", 2,
    "You are a translation assistant. Respond ONLY with the translated text, without any additional text, quotes, or explanations."
  );

  // Cache the result
  setCachedTranslation(text, languages.join('_'), translation);
  return translation;
}

// Main function to execute the script
async function main() {
  try {
    const selectedText = getSelectedText(logger);

    // Check if there is a selected text
    if (selectedText && selectedText.trim().length > 0) {
      // Generate the translation of the selected text
      const generatedText = await translate(selectedText);

      if (generatedText) {
        pasteText(generatedText, logger);
      }
      exit(0);
    } else {
      logger.error("Error: No valid text selected");
      exit(1);
    }
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
