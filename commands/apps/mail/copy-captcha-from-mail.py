#!/usr/bin/env python3

# Copy the verification code from Mail.
#
# Dependency: This script requires the `emlx` package.
# Install it via `pip install emlx`.
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title CaptchaFromMail
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/mail.png
# @raycast.packageName Mail

# Documentation:
# @raycast.description Copy the captcha from the emlx file.
# @raycast.author RealTong
# @raycast.authorURL https://raycast.com/RealTong

import os
import re
import pyperclip
import emlx


def extract_captcha_from_emlx(emlx_path):
    if emlx_file is None or os.path.exists(emlx_file) is False:
        print("Mail not found")
        return
    email = emlx.read(emlx_path)
    headers = email.headers
    content = email.html
    subject = headers["Subject"]
    captcha_match_keyword = [
        "验证码",
        "动态密码",
        "代码",
        "确认",
        "码",
        "verification",
        "code",
        "confirm",
    ]
    content_pattern = r"\b[0-9]{6}\b"
    subject_pattern = r"\b[a-zA-Z0-9]{6}\b"
    # 判断内容中是否包含验证码关键字, 只有包含关键字的邮件才会查找验证码
    for keyword in captcha_match_keyword:
        if keyword in subject:
            if re.search(subject_pattern, subject):
                captcha = re.search(subject_pattern, subject).group()
                pyperclip.copy(captcha)
                print("Verification code successfully copied to clipboard:", captcha)
                return
            if re.search(content_pattern, content):
                captcha = re.search(content_pattern, content).group()
                pyperclip.copy(captcha)
                print("Verification code successfully copied to clipboard:", captcha)
                return
            else:
                print("Verification code not found")
        else:
            print("Not a verification code email")


def get_latest_emlx_file(folder):
    latest_emlx_file = None
    latest_mod_time = 0
    for root, dirs, files in os.walk(folder):
        for file in files:
            if file.endswith(".emlx"):
                file_path = os.path.join(root, file)
                mod_time = os.path.getmtime(file_path)
                if mod_time > latest_mod_time:
                    latest_mod_time = mod_time
                    latest_emlx_file = file_path

    return latest_emlx_file


if __name__ == "__main__":
    try:
        import emlx

        os.listdir(f"/")
    except ImportError:
        print("emlx not installed, please run 'pip install emlx' to install it")
        exit(1)
    except OSError:
        print(
            "Currently there is no Full Disk Access permission， please grant Full Disk Access permission to the terminal in System Preferences > Security & Privacy > Privacy > Full Disk Access."
        )
        exit(1)
    mail_path = f"{os.path.expanduser('~')}/Library/Mail/V10/"
    emlx_file = get_latest_emlx_file(mail_path)
    extract_captcha_from_emlx(emlx_file)
