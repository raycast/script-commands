#!/usr/bin/env node

// Required Dependencies:
// - Node.js (https://nodejs.org/en/download/)
// - OpenAI API Key
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Text Insight Generator
// @raycast.mode fullOutput
// @raycast.packageName AI Assistant
// @raycast.icon 🔍

// Documentation:
// @raycast.description Analyze selected text in various ways (explain, summarize, simplify, extract key points, etc.)
// @raycast.author Alexandre Pezzotta
// @raycast.authorURL https://github.com/pezzos
//
// Features:
// - Multiple analysis modes:
//   • Detailed explanation
//   • Concise summary
//   • Simplified explanation (ELI8)
//   • Key points extraction
//   • To-Do list generation
//   • Translation
//   • Pattern & insight discovery
//   • Question generation
//   • Mind map creation
// - Smart text selection from multiple sources:
//   • Browser selection (Safari, Chrome, Arc)
//   • System-wide text selection
//   • Clipboard fallback
// - Color-coded output for better readability
// - Result caching for improved performance
// - Multi-language support
//
// Configuration:
// Create a .env file in the same directory with the following variables:
// ```
// OPENAI_API_KEY=sk-your-api-key    # Required: Your OpenAI API key
// DEFAULT_LANG=fr                    # Optional: Default language for translations
// ```
//
// Usage:
// 1. Select text in any application
// 2. Trigger the command through Raycast
// 3. Choose the desired analysis type from the dropdown
// 4. View the formatted analysis with:
//    • Original text preview
//    • Analysis results
//    • Appropriate formatting based on analysis type
//
// Note: For optimal results:
// - Select clear and coherent text for analysis
// - Choose the most appropriate analysis type for your needs
// - For translations, ensure DEFAULT_LANG is set or use system defaults
// - Analysis preserves the original language unless translation is selected
//
// @raycast.argument1 { "type": "dropdown", "placeholder": "Select analysis type", "data": [{ "title": "Explain in detail", "value": "explain" },{ "title": "Summarize", "value": "summarize" },{ "title": "Explain like I'm 8", "value": "eli8" },{ "title": "Extract key points", "value": "keypoints" },{ "title": "Create To-Do list", "value": "todo" },{ "title": "Translate", "value": "translate" },{ "title": "Find patterns & insights", "value": "patterns" },{ "title": "Generate questions", "value": "questions" },{ "title": "Create mind map", "value": "mindmap" }]}

import { exit } from 'process';
import { createChatCompletion, getCachedTranslation, setCachedTranslation, createLogger } from './lib/common.js';
import { config } from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import { execSync } from 'child_process';

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

// Get analysis type from command line arguments
const analysisType = process.argv[2];
let targetLanguage;

// If no target language is provided for translation, use the default from .env
if (analysisType === 'translate') {
  targetLanguage = process.env.DEFAULT_LANG;
  if (!targetLanguage) {
    console.log("Error: No target language provided and DEFAULT_LANG not set in .env file");
    exit(1);
  }
  logger.info(`Using default language: ${targetLanguage}`);
}

// Define analysis prompts and formatting for each type
const ANALYSIS_TYPES = {
  explain: {
    prompt: "Please explain this text in detail, breaking down complex concepts and providing context:",
    title: "📚 Detailed Explanation",
    format: (text) => text
  },
  summarize: {
    prompt: "Please provide a clear and concise summary of this text:",
    title: "📝 Summary",
    format: (text) => text
  },
  eli8: {
    prompt: "Please explain this text as if you were explaining it to an 8-year-old child:",
    title: "🎈 Simple Explanation",
    format: (text) => text
  },
  keypoints: {
    prompt: "Please extract and list the key points from this text:",
    title: "🎯 Key Points",
    format: (text) => text.split('\n').map(point => `• ${point}`).join('\n')
  },
  todo: {
    prompt: "Please create a to-do list of actionable items based on this text:",
    title: "✅ To-Do List",
    format: (text) => text.split('\n').map(task => `□ ${task}`).join('\n')
  },
  translate: {
    prompt: (lang) => `Please translate this text into ${lang}, maintaining the tone and meaning:`,
    title: "🌍 Translation",
    format: (text) => text
  },
  patterns: {
    prompt: "Please analyze this text for patterns, trends, and interesting insights:",
    title: "🔎 Patterns & Insights",
    format: (text) => text
  },
  questions: {
    prompt: "Please generate relevant questions that could be asked about this text:",
    title: "❓ Questions",
    format: (text) => text.split('\n').map(q => `? ${q}`).join('\n')
  },
  mindmap: {
    prompt: "Please create a text-based mind map or hierarchical structure of the main concepts in this text:",
    title: "🌳 Mind Map",
    format: (text) => text
  }
};

// Function to format the output with colors and emojis
function formatOutput(originalText, analysisResult, type) {
  const analysisType = ANALYSIS_TYPES[type];
  return `${colors.blue}${colors.bold}📌 Original Text${colors.reset}
${colors.cyan}${originalText.substring(0, 150)}${originalText.length > 150 ? '...' : ''}${colors.reset}

${colors.green}${colors.bold}${analysisType.title}${colors.reset}
${colors.yellow}${analysisType.format(analysisResult)}${colors.reset}`;
}

// Function to analyze the text using OpenAI API
async function analyzeText(text, type, targetLang = '') {
  // Check cache first
  const cacheKey = `analyze_${type}_${targetLang}`;
  const cachedResult = getCachedTranslation(text, cacheKey);
  if (cachedResult) {
    logger.info("Using cached analysis");
    return cachedResult;
  }

  const analysisType = ANALYSIS_TYPES[type];
  const prompt = typeof analysisType.prompt === 'function'
    ? analysisType.prompt(targetLang)
    : analysisType.prompt;

  const fullPrompt = `${prompt}
"${text}"

Rules:
- Be thorough but clear in your analysis
- Use appropriate formatting for the selected analysis type
- Keep any technical terms or specific references
- If the input is not in English and the type is not 'translate', respond in the same language as the input
- For translations, ensure high quality and natural-sounding output`;

  const analysis = await createChatCompletion(fullPrompt, "gpt-4o-mini", 2,
    "You are a text analysis assistant. Provide a clear and well-structured analysis based on the requested type."
  );

  // Cache the result
  setCachedTranslation(text, cacheKey, analysis);
  return analysis;
}

// Function to get selected text using AppleScript
function getSelectedTextFromScreen() {
  try {
    // Using single quotes for the outer script to avoid escaping issues
    const script = `
      tell application "System Events"
        set frontApp to name of first application process whose frontmost is true
      end tell

      set selectedText to ""

      if frontApp is "Safari" then
        tell application "Safari"
          set selectedText to do JavaScript "window.getSelection().toString()" in current tab of first window
        end tell
      else if frontApp is "Google Chrome" then
        tell application "Google Chrome"
          tell active tab of first window
            set selectedText to execute javascript "window.getSelection().toString()"
          end tell
        end tell
      else if frontApp is "Arc" then
        tell application "Arc"
          tell active tab of first window
            set selectedText to execute javascript "window.getSelection().toString()"
          end tell
        end tell
      else
        -- For other applications, use clipboard
        tell application "System Events"
          keystroke "c" using {command down}
          delay 0.1
        end tell
        set selectedText to (do shell script "pbpaste")
      end if

      return selectedText
    `;

    const result = execSync(`osascript -e '${script}'`).toString().trim();
    return result;
  } catch (error) {
    logger.error("Error getting selected text:", error);
    // Fallback to clipboard if AppleScript fails
    try {
      execSync('osascript -e \'tell application "System Events" to keystroke "c" using {command down}\'');
      return execSync('pbpaste').toString().trim();
    } catch (fallbackError) {
      logger.error("Fallback clipboard method failed:", fallbackError);
      return null;
    }
  }
}

// Main function to execute the script
async function main() {
  try {
    const selectedText = getSelectedTextFromScreen();

    // Check if there is a selected text
    if (!selectedText || selectedText.trim().length === 0) {
      console.log("Error: No text selected. Please select some text and try again.");
      exit(1);
    }

    // Check if analysis type is valid
    if (!ANALYSIS_TYPES[analysisType]) {
      console.log("Error: Invalid analysis type");
      exit(1);
    }

    // For translation, ensure target language is provided or default exists
    if (analysisType === 'translate' && (!targetLanguage || targetLanguage.trim().length === 0)) {
      console.log("Error: Target language is required for translation and DEFAULT_LANG not set in .env file");
      exit(1);
    }

    // Generate the analysis
    const analysisResult = await analyzeText(selectedText, analysisType, targetLanguage);

    if (analysisResult) {
      console.log(formatOutput(selectedText, analysisResult, analysisType));
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
