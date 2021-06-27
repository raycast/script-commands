#!/usr/bin/env python3

# Dependency: This script requires `gifski` to be installed: https://gif.ski/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create GIF from video
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📹
# @raycast.argument1 { "type": "text", "placeholder": "Source File Path", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "FPS (Default: 20)", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Width (Default 600)", "optional": true }
# @raycast.packageName Conversions

# Documentation:
# @raycast.description Create a GIF from video, by default it takes the last screen record video
# @raycast.author Quentin Eude
# @raycast.authorURL https://github.com/qeude

import mimetypes
import os
import subprocess
import sys

from datetime import datetime
from glob import glob
from pathlib import Path
from shutil import which

if which("gifski") is None:
    print("gifski is required (https://gif.ski/).")
    exit(1)

if which("ffmpeg") is None:
    print("ffmpeg is required (https://www.ffmpeg.org/).")
    exit(1)

base_directory=f"{os.environ['HOME']}/Desktop"

default_gif_filename=f"generated_gif_{datetime.now().astimezone().isoformat()}.gif"

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

def handle_error(stderr):
    if stderr:
        print(stderr)
        exit(1)

from_file_path=safe_get(sys.argv, 1) or get_last_video_file_path()

if not from_file_path:
    print("No video file have been found at the specified path.")
    exit(1)

if os.path.isdir(from_file_path) or not is_video_file(from_file_path):
    print("Source file should be a valid video file.")
    exit(1)

frame_rate=safe_get(sys.argv, 2) or 20
width=safe_get(sys.argv, 3) or 600
to_file_path=get_default_destination_file_path(from_file_path)

try:
    int_width = int(width)
except Exception as e:
    print(f"Width should be a valid integer between 1 and 5120.")
    exit(1)

if int_width > 5120 or int_width < 1:
    print(f"Width should be a valid integer between 1 and 5120.")
    exit(1)

try:
    int_frame_rate = int(frame_rate)
except Exception as e:
    print(f"Frame rate should be valid integer between 1 and 60.")
    exit(1)

if int_frame_rate <= 60 and int_frame_rate >= 1:
    mp4_filename=f".{os.path.splitext(os.path.basename(from_file_path))[0]}_{datetime.now().astimezone().isoformat()}.mp4"
    mp4_file_path=os.path.join(os.path.dirname(from_file_path), mp4_filename)
    cmd = ["ffmpeg", "-y", "-loglevel", "panic", "-err_detect", "aggressive", "-fflags", "discardcorrupt", "-i", from_file_path, "-c:v", "libx264", "-preset", "slow", "-crf", "18", "-c:a", "copy", mp4_file_path]
    stderr_str = subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE).stderr
    handle_error(stderr_str)
    cmd = ["gifski", "--repeat", "0", "-W", str(int_width), "--fps", str(int_frame_rate), "-o", to_file_path, mp4_file_path]
    stderr_str = subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE).stderr
    handle_error(stderr_str)
    os.remove(mp4_file_path)
    subprocess.run("pbcopy", universal_newlines=True, input=to_file_path)
    print("GIF successfully generated 🎉")
    exit(0)

print(f"Frame rate should be valid integer between 1 and 60.")
exit(0)
