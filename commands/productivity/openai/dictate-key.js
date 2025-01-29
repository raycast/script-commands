#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/
// Install SOX: brew install sox
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Dictate (Stop with Key)
// @raycast.mode silent
// @raycast.packageName AI Assistant
// @raycast.icon 🎙️

// Optional parameters:
// @raycast.argument1 { "type": "dropdown", "placeholder": "Output Language", "data": [{ "title": "English", "value": "en" }, { "title": "Français", "value": "fr" }, { "title": "Español", "value": "es" }, { "title": "Deutsch", "value": "de" }, { "title": "Italiano", "value": "it" }, { "title": "Português", "value": "pt" }, { "title": "Nederlands", "value": "nl" }, { "title": "Русский", "value": "ru" }, { "title": "中文", "value": "zh" }, { "title": "日本語", "value": "ja" }, { "title": "한국어", "value": "ko" }], "optional": true }

// Documentation:
// @raycast.description This script records your voice until you press any key, then converts it to text directly in the clipboard, translating to the selected language if needed.
// @raycast.author Alexandre Pezzotta
// @raycast.authorURL pezzos.com

import { exit } from 'process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { spawn } from 'child_process';
import { openai, pasteText, createLogger } from './lib/common.js';
import { config } from 'dotenv';
import notifier from 'node-notifier';
// import * as readline from 'readline';
// import { execSync } from 'child_process';

// Initialize paths
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const RECORDINGS_DIR = path.join(__dirname, "recordings");

// Initialize logger
const logger = createLogger(import.meta.url);

// Load environment variables from .env file
config({ path: path.join(__dirname, '.env') });

// Validate required environment variables
if (!process.env.OPENAI_API_KEY) {
  logger.error("Error: OPENAI_API_KEY is not set in .env file");
  exit(1);
}

// Language mapping for display names
const LANGUAGE_NAMES = {
  'en': 'English',
  'fr': 'Français',
  'es': 'Español',
  'de': 'Deutsch',
  'it': 'Italiano',
  'pt': 'Português',
  'nl': 'Nederlands',
  'ru': 'Русский',
  'zh': '中文',
  'ja': '日本語',
  'ko': '한국어'
};

// // Validate language input against .env configuration
// function validateLanguage(inputLang) {
//   const availableLangs = process.env.LANGS?.split(',').map(lang => lang.trim()) || [];

//   if (availableLangs.length === 0) {
//     logger.error("No languages defined in .env file (LANGS variable)");
//     showToast("Error: No languages defined in .env", "error");
//     exit(1);
//   }

//   if (!inputLang) {
//     return availableLangs[0];
//   }

//   if (!availableLangs.includes(inputLang)) {
//     logger.error(`Invalid language: ${inputLang}. Available languages: ${availableLangs.join(', ')}`);
//     showToast(`Invalid language. Available: ${availableLangs.join(', ')}`, "error");
//     exit(1);
//   }

//   return inputLang;
// }

// // Get selected language from command line argument
// const selectedLang = validateLanguage(process.argv[2]);

// Function to ensure recordings directory exists
const ensureRecordingDir = () => {
  if (!fs.existsSync(RECORDINGS_DIR)) {
    fs.mkdirSync(RECORDINGS_DIR);
  }
  return RECORDINGS_DIR;
};

// Function to generate recording filename
const getRecordingPath = () => {
  return path.join(
    RECORDINGS_DIR,
    `recording-${new Date().getTime()}.wav`
  );
};

// Function to show Toast notification
function showToast(message, icon) {
  const emojis = {
    mic: '🎙️',
    processing: '🔄',
    paste: '📋',
    success: '✅',
    error: '❌'
  };

  notifier.notify({
    title: 'Dictation',
    message: `${emojis[icon]} ${message}`,
    sound: false,
    timeout: 2
  });
}

// Function to record audio until key press
async function captureAudio() {
  ensureRecordingDir();
  const fileName = getRecordingPath();
  logger.info("Recording started... Press Control+C to stop recording");

  showToast("Recording in progress (press Control+C to stop)", "mic");

  // Setup SOX recording process with simpler options
  const rec = spawn('sox', [
    '-d',                    // Use default audio input
    fileName,                // Output file
    'rate', '16000',        // Sample rate in Hz
    'channels', '1',        // Mono audio
  ]);

  return new Promise((resolve, reject) => {
    const stopRecording = () => {
      rec.kill();
      logger.info("Recording stopped by user");
      showToast("Processing your dictation", "processing");
      resolve(fileName);
    };

    // Handle Control+C
    process.on('SIGINT', () => {
      stopRecording();
    });

    rec.on('error', (error) => {
      logger.error("Recording error:", error);
      reject(error);
    });

    // Handle process termination
    rec.on('exit', (code) => {
      if (code !== 0 && code !== null) {
        logger.error(`Recording process exited with code ${code}`);
        reject(new Error(`Recording process exited with code ${code}`));
      }
    });
  });
}

// Function to transcribe and translate text if needed
async function transcribeAndTranslate(audioFile, targetLang) {
  try {
    logger.info("Converting speech to text...");

    // Get the transcription with automatic language detection
    const transcription = await openai.audio.transcriptions.create({
      file: fs.createReadStream(audioFile),
      model: "whisper-1",
      response_format: "text",
      temperature: 0.3
    });

    // Only translate if a target language is explicitly specified
    if (targetLang && targetLang.trim()) {
      logger.info(`Translating to ${LANGUAGE_NAMES[targetLang]}...`);

      const messages = [
        {
          role: "system",
          content: `You are a translator. Translate the following text to ${LANGUAGE_NAMES[targetLang]}. Preserve the tone and style of the original text. Keep technical terms intact when appropriate.`
        },
        {
          role: "user",
          content: transcription
        }
      ];

      const completion = await openai.chat.completions.create({
        model: "gpt-4",
        messages: messages,
        temperature: 0.3,
        max_tokens: 1000
      });

      return completion.choices[0].message.content;
    }

    // If no target language specified, return the transcription as is
    return transcription;
  } catch (error) {
    logger.error("Error in transcription/translation process:", error);
    throw error;
  }
}

// Main function to execute the script
async function main() {
  try {
    logger.info('Starting dictation process...');
    const recording = await captureAudio();

    // Get target language from argument (might be undefined if not provided)
    const targetLang = process.argv[2];

    showToast(targetLang ? "Processing and translating audio" : "Processing audio", "processing");
    const processedText = await transcribeAndTranslate(recording, targetLang);

    if (processedText?.trim()) {
      showToast("Pasting text", "paste");
      await pasteText(processedText, logger);

      // Clean up recording if not keeping records
      if (process.env.KEEP_RECORD !== "true") {
        fs.unlinkSync(recording);
        logger.info("Recording file cleaned up.");
      }

      showToast("Text processed and pasted!", "success");
      exit(0);
    } else {
      throw new Error("No text was transcribed");
    }
  } catch (error) {
    logger.error("Error in dictation process:", error);
    showToast("Error during dictation", "error");
    exit(1);
  }
}

// Execute the main function
main();
