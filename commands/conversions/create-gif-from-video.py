#!/usr/bin/env python3

# Dependency: This script requires `gifski` to be installed: https://gif.ski/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create GIF from video
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📹
# @raycast.argument1 { "type": "text", "placeholder": "Path to the source file (default: take the last screen recording on the Desktop)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Path to the destination file (default: generate a file in the same directory as the source file)", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "FPS (between 1 and 60, default: 60)", "optional": true }
# @raycast.packageName Conversions

# Documentation:
# @raycast.description Create a GIF from video, by default it takes the last screen record video
# @raycast.author Quentin Eude
# @raycast.authorURL https://github.com/qeude

import sys
import mimetypes
from glob import glob
import os
from shutil import which
import subprocess
from pathlib import Path

if which("gifski") is None:
    print("gifski is required (https://gif.ski/).")
    exit(1)

base_directory=f"{os.environ['HOME']}/Desktop"

default_gif_filename="generated_gif.gif"

def is_video_file(file_path):
    return mimetypes.guess_type(file_path)[0].startswith('video')

def get_last_video_file_path():
    files = [x for x in glob(f"{base_directory}/**") if is_video_file(os.path.abspath(x))]
    return os.path.abspath(max(files, key=os.path.getctime))

def get_default_destination_file_path(from_file_path):
    destination_directory_path = os.path.abspath(os.path.join(from_file_path, os.pardir))
    return os.path.join(destination_directory_path, default_gif_filename)

def safe_get(array, index):
    try:
        return array[index]
    except IndexError:
        return None

from_file_path=safe_get(sys.argv, 1) or get_last_video_file_path()
to_file_path=safe_get(sys.argv, 2) or get_default_destination_file_path(from_file_path=from_file_path)
frame_rate=safe_get(sys.argv, 3) or 30

if not from_file_path:
    print("No video file have been found at the specified path.")
    exit(1)

if os.path.isdir(from_file_path) and is_video_file(from_file_path):
    print("Source file should be a valid video file.")
    exit(1)

if os.path.isdir(to_file_path):
    to_file_path=os.path.join(to_file_path, default_gif_filename)

if not os.path.isdir(to_file_path) and Path(to_file_path).suffix != ".gif":
    print("Destination file should be a '.gif' file.")
    exit(1)

try:
    int_frame_rate = int(frame_rate)
except Exception as e:
    print(f"Frame rate should be valid integer between 1 and 60.")
    exit(1)

if int_frame_rate <= 60 and int_frame_rate >= 1:
    mp4_filename=f".{os.path.splitext(os.path.basename(from_file_path))[0]}.mp4"
    mp4_file_path=os.path.join(os.path.dirname(from_file_path), mp4_filename)
    os.system(f"ffmpeg -y -loglevel panic -err_detect aggressive -fflags discardcorrupt -i '{from_file_path}' -c:v libx264 -preset slow -crf 18 -c:a copy '{mp4_file_path}'>/dev/null")
    os.system(f"gifski --fps {int_frame_rate} -o '{to_file_path}' '{mp4_file_path}'>/dev/null")
    os.remove(mp4_file_path)
    subprocess.run("pbcopy", universal_newlines=True, input=to_file_path)
    print("GIF successfully generated 🎉")
    exit(0)

print(f"Frame rate should be valid integer between 1 and 60.")
exit(1)
