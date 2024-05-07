#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Markdown to Telegram Format
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄
# @raycast.packageName Conversions
# @raycast.description Convert Markdown formatting to Telegram format, excluding processing inside code blocks or quotes

# Documentation:
# @raycast.author Maxim Borzov
# @raycast.authorURL https://github.com/borzov

import re
import subprocess

# Set environment variables and encoding
env_vars = {'LANG': 'en_US.UTF-8'}
encoding = 'utf-8'

def paste():
    """Read text from the clipboard."""
    return subprocess.check_output('pbpaste', env=env_vars).decode(encoding)

def copy(text):
    """Write text to the clipboard."""
    process = subprocess.Popen('pbcopy', env=env_vars, stdin=subprocess.PIPE)
    process.communicate(text.encode(encoding))

def convert_markdown(text):
    """Convert Markdown formatting to Telegram format."""
    lines = text.split('\n')
    converted_lines = []
    in_code_block = False

    for line in lines:
        # Check if the line is a code block delimiter
        if line.startswith('```'):
            in_code_block = not in_code_block
            converted_lines.append(line)
            continue

        # Skip quotes and only format if not in a code block
        if not in_code_block and not line.startswith('>'):
            # Format headers with emojis and bold text
            if line.startswith('# '):
                line = f"⚫️ **{line[2:].strip()}**\n"
            elif line.startswith('## '):
                line = f"◾️ **{line[3:].strip()}**\n"
            elif line.startswith('### '):
                line = f"▪️ **{line[4:].strip()}**\n"
            elif line.startswith('#### '):
                line = f"🔹 **{line[5:].strip()}**\n"
            elif line.startswith('##### '):
                line = f"📌 **{line[6:].strip()}**\n"
            elif line.startswith('###### '):
                line = f"🔰 **{line[7:].strip()}**\n"
            else:
                # Format bold text
                line = re.sub(r'(?<!\\)\*{2}(.*?)\*{2}', r'**\1**', line)
                line = re.sub(r'(?<!\\)_{2}(.*?)_{2}', r'**\1**', line)
                # Format italic text
                line = re.sub(r'(?<!\\|\*)\*(?!\*)(.+?)(?<!\*)\*(?![\*_])', r'__\1__', line)
                line = re.sub(r'(?<!\\|_)_(?!_)(.+?)(?<!_)_(?![\*_])', r'__\1__', line)
                # Format strikethrough text
                line = re.sub(r'(?<!\\)~{2}(.*?)~{2}', r'~~\1~~', line)
                # Format spoilers
                line = re.sub(r'(?<!\\)\|\|(.*?)\|\|', r'||\1||', line)
                # Format underline text
                line = re.sub(r'(?<!\\)-{2}(.*?)-{2}', r'--\1--', line)
                # Format links
                line = re.sub(r'(?<!\\)\[(.*?)\]\((.*?)\)', r'[\1](\2)', line)
                # Format inline code
                line = re.sub(r'(?<!\\)`(.*?)`', r'`\1`', line)

        converted_lines.append(line)

    # Add empty lines between paragraphs
    result = []
    for i in range(len(converted_lines)):
        result.append(converted_lines[i])
        if i < len(converted_lines) - 1:
            cur = converted_lines[i].strip()
            next = converted_lines[i+1].strip()
            if cur and next and not cur.startswith(('*', '-', '```', '|', '>')) and not next.startswith(('*', '-', '```', '|', '>')):
                result.append('')

    return '\n'.join(result)

if __name__ == "__main__":
    try:
        markdown_text = paste()
        converted_text = convert_markdown(markdown_text)
        copy(converted_text)
        print("✅ Markdown converted and copied to clipboard")
    except Exception as e:
        print(f"❌ Error during conversion: {str(e)}")