#!/usr/bin/env python3

# Dependency: This script requires Pillow Python module
# Install via Python: python3 -m pip install Pillow

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Save Image From Clipboard
# @raycast.mode silent
# @raycast.packageName Clipboard

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Save Image From Clipboard
# @raycast.author Yufei Kang
# @raycast.authorURL kangyufei.net
# @raycast.author LanikSJ
# @raycast.authorURL https://github.com/LanikSJ

from datetime import datetime
from pathlib import Path

from PIL import ImageGrab

home = Path.home()


def save_image():
    im = ImageGrab.grabclipboard()
    if im != None:
        filepath = home / "Downloads/ScreenShot-{}.png".format(
            datetime.now().strftime("%Y%m%d-%H%M%S")
        )
        im.save(filepath.as_posix())
        print(f"OK Saved In: {filepath}")
    else:
        print("No Image in Clipboard")


if __name__ == "__main__":
    save_image()

