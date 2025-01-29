#!/usr/bin/env node

// Required Dependencies:
// - Node.js (https://nodejs.org/en/download/)
// - OpenAI API Key
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Improve Text
// @raycast.mode silent
// @raycast.packageName AI Assistant
// @raycast.icon ✨

// Documentation:
// @raycast.description Improve selected text using AI with various enhancement options
// @raycast.author Alexandre Pezzotta
// @raycast.authorURL https://github.com/pezzos
//
// Features:
// - Multiple improvement modes:
//   • Text expansion and elaboration
//   • Conciseness optimization
//   • Professional tone enhancement
//   • Impact strengthening
//   • Emotional neutralization
//   • Friendliness improvement
//   • Bullet point conversion
//   • Grammar and style correction
// - Language preservation (maintains original language)
// - Format and structure preservation
// - Technical term preservation
// - Result caching for improved performance
//
// Configuration:
// Create a .env file in the same directory with the following variables:
// ```
// OPENAI_API_KEY=sk-your-api-key    # Required: Your OpenAI API key
// ```
//
// Usage:
// 1. Select text in any application
// 2. Trigger the command through Raycast
// 3. Choose the desired improvement type from the dropdown
// 4. The improved text will replace your selection
//
// Note: For optimal results:
// - Ensure the selected text is clear and well-structured
// - Choose the most appropriate improvement type for your needs
// - For technical content, the script will preserve specialized terminology
// - The improvement maintains the original language of the text
//
// @raycast.argument1 { "type": "dropdown", "placeholder": "Select improvement type", "data": [{ "title": "Make it longer", "value": "longer" },{ "title": "Make it more concise", "value": "concise" },{ "title": "Make it more professional", "value": "professional" },{ "title": "Make it more impactful", "value": "impactful" },{ "title": "Make it less emotional", "value": "less_emotional" },{ "title": "Make it nicer", "value": "nicer" },{ "title": "Turn into bullet points", "value": "bullets" },{ "title": "Fix grammar and style", "value": "fix" }]}

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

// Get improvement type from command line arguments
const improvementType = process.argv[2];

// Define improvement prompts for each type
const IMPROVEMENT_PROMPTS = {
  longer: "Expand and elaborate on this text while maintaining its core message and adding relevant details:",
  concise: "Make this text more concise while preserving its key message:",
  professional: "Rewrite this text in a more professional and formal tone:",
  impactful: "Enhance this text to make it more powerful and impactful:",
  less_emotional: "Rewrite this text in a more neutral and objective tone:",
  nicer: "Rewrite this text to make it more friendly and positive:",
  bullets: "Convert this text into a well-organized bullet point list:",
  fix: "Fix any grammar, spelling, punctuation issues, and improve the overall style of this text:"
};

// Function to improve the text using OpenAI API
async function improveText(text, type) {
  // Check cache first
  const cacheKey = `improve_${type}`;
  const cachedResult = getCachedTranslation(text, cacheKey);
  if (cachedResult) {
    logger.info("Using cached improvement");
    return cachedResult;
  }

  const prompt = `${IMPROVEMENT_PROMPTS[type]}
"${text}"

Rules:
- IMPORTANT: Keep the exact same language as the input text - DO NOT translate
- Maintain the original meaning and key points
- Keep any technical terms or specific references
- Ensure the output is well-structured and clear
- Match the appropriate tone for the selected improvement type
- If the input is in French, respond in French
- If the input is in English, respond in English
- If the input is in any other language, keep that same language`;

  const improvement = await createChatCompletion(prompt, "gpt-4o-mini", 2,
    "You are a text improvement assistant. Respond ONLY with the improved text in the SAME LANGUAGE as the input, without any additional text, quotes, or explanations."
  );

  // Cache the result
  setCachedTranslation(text, cacheKey, improvement);
  return improvement;
}

// Main function to execute the script
async function main() {
  try {
    const selectedText = getSelectedText(logger);

    // Check if there is a selected text
    if (!selectedText || selectedText.trim().length === 0) {
      logger.error("Error: No valid text selected");
      exit(1);
    }

    // Check if improvement type is valid
    if (!IMPROVEMENT_PROMPTS[improvementType]) {
      logger.error("Error: Invalid improvement type");
      exit(1);
    }

    // Generate the improved text
    const improvedText = await improveText(selectedText, improvementType);

    if (improvedText) {
      pasteText(improvedText, logger);
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
