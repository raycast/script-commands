#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Markdown to Telegram Format
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄
# @raycast.packageName Content Tools
# @raycast.description Convert Markdown formatting to Telegram format, excluding processing inside code blocks or quotes

# Documentation:
# @raycast.author Maxim Borzov

import re
import subprocess

def paste():
    return subprocess.check_output('pbpaste', env={'LANG': 'en_US.UTF-8'}).decode('utf-8')

def copy(text):
    process = subprocess.Popen('pbcopy', env={'LANG': 'en_US.UTF-8'}, stdin=subprocess.PIPE)
    process.communicate(text.encode('utf-8'))

def convert_markdown(text):
    lines = text.split('\n')
    converted_lines = []
    in_code_block = False

    for line in lines:
        if line.startswith('```'):
            in_code_block = not in_code_block
            converted_lines.append(line)
            continue

        if not in_code_block and not line.startswith('>'):  # Skip quotes
            # Format headers
            if line.startswith('# '):
                line = f"🔰 **{line[2:].strip()}**\n"
            elif line.startswith('## '):
                line = f"📌 **{line[3:].strip()}**\n"
            elif line.startswith('### '):
                line = f"🔹 **{line[4:].strip()}**\n"
            elif line.startswith('#### '):
                line = f"▪️ **{line[5:].strip()}**\n"
            elif line.startswith('##### '):
                line = f"◾️ **{line[6:].strip()}**\n"
            elif line.startswith('###### '):
                line = f"⚫️ **{line[7:].strip()}**\n"
            else:  # Only format if not a header
                line = re.sub(r'(?<!\\)\*{2}(.*?)\*{2}', r'**\1**', line)  # Bold
                line = re.sub(r'(?<!\\)_{2}(.*?)_{2}', r'**\1**', line)  # Also bold
                line = re.sub(r'(?<!\\|\*)\*(?!\*)(.+?)(?<!\*)\*(?![\*_])', r'__\1__', line)  # Italic
                line = re.sub(r'(?<!\\|_)_(?!_)(.+?)(?<!_)_(?![\*_])', r'__\1__', line)  # Also italic
                line = re.sub(r'(?<!\\)~{2}(.*?)~{2}', r'~~\1~~', line)  # Strikethrough
                line = re.sub(r'(?<!\\)\|\|(.*?)\|\|', r'||\1||', line)  # Spoiler
                line = re.sub(r'(?<!\\)-{2}(.*?)-{2}', r'--\1--', line)  # Underline
                line = re.sub(r'(?<!\\)\[(.*?)\]\((.*?)\)', r'[\1](\2)', line)  # Links
                line = re.sub(r'(?<!\\)`(.*?)`', r'`\1`', line)  # Inline code

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
