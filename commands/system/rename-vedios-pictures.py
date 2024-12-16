#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Rename Video
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📂
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }

# Documentation:
# @raycast.description This is a simple Python script for recursively renaming video and picture files within a directory. Type the root directory's absolute path, and it will scan all the video and picture files in it and rename them according to the folder where they are located as the format `<folder_name>-<current_date (MMDD)>-<incremental_number>`.
# @raycast.author StepaniaH
# @raycast.authorURL https://github.com/StepaniaH

import os
import sys
import datetime
import argparse
import re

class RenameFilesAsDate:
    def __init__(self, root_directory):
        self.root_directory = os.path.expanduser(root_directory)
        self.error_files = {}
        self.video_extensions = ('.mp4', '.avi', '.mov', '.mkv', '.wmv')
        self.image_extensions = ('.jpg', '.jpeg', '.png', '.gif', 'webp')

    def rename_files(self, file_type='all', dry_run=False):
        current_date = datetime.datetime.now().strftime("%m%d")
        self._process_directory(self.root_directory, current_date, file_type, dry_run)

        if self.error_files:
            print("\nThe following files could not be renamed:")
            for original_path, error in self.error_files.items():
                print(f"{original_path}: {error}")

    def _is_already_renamed(self, filename, current_date):
        """Check if the file has been named according to the target format"""
        base_name = os.path.splitext(filename)[0]
        pattern = re.compile(f'^.*-{current_date}-\\d{{2}}$')
        return bool(pattern.match(base_name))

    def _get_max_sequence_number(self, directory, current_date):
        """Get the largest serial number existing in the current directory"""
        max_seq = 0
        pattern = re.compile(f'^.*-{current_date}-(\\d{{2}}).*$')
        
        for entry in os.listdir(directory):
            match = pattern.match(os.path.splitext(entry)[0])
            if match:
                seq_num = int(match.group(1))
                max_seq = max(max_seq, seq_num)
        return max_seq

    def _process_directory(self, directory, current_date, file_type, dry_run):
        folder_name = os.path.basename(directory)
        supported_extensions = self._get_supported_extensions(file_type)
        
        # First collect the files that need to be renamed
        files_to_rename = []
        for entry in os.listdir(directory):
            entry_path = os.path.join(directory, entry)

            if os.path.isfile(entry_path):
                if entry.lower().endswith(supported_extensions):
                    if not self._is_already_renamed(entry, current_date):
                        files_to_rename.append(entry)
            elif os.path.isdir(entry_path):
                self._process_directory(entry_path, current_date, file_type, dry_run)

        if files_to_rename:
            # Get the largest serial number existing in the current directory
            count = self._get_max_sequence_number(directory, current_date) + 1

            # Rename collected files
            for entry in sorted(files_to_rename):  # Sort to ensure consistent rename order
                entry_path = os.path.join(directory, entry)
                new_name = f"{folder_name}-{current_date}-{count:02d}{os.path.splitext(entry)[1].lower()}"
                new_path = os.path.join(directory, new_name)

                if dry_run:
                    print(f"Would rename: {entry} -> {new_name}")
                else:
                    try:
                        os.rename(entry_path, new_path)
                        print(f"Renamed: {entry} -> {new_name}")
                    except OSError as e:
                        self.error_files[entry_path] = f"Rename failed: {str(e)}"
                        continue
                count += 1

    def _get_supported_extensions(self, file_type):
        if file_type == 'video':
            return self.video_extensions
        elif file_type == 'image':
            return self.image_extensions
        return self.video_extensions + self.image_extensions

def main():
    parser = argparse.ArgumentParser(description='Rename video and image files with date pattern')
    parser.add_argument('directory', help='Root directory to process')
    parser.add_argument('--type', choices=['video', 'image', 'all'], 
                        default='all', help='File type to process')
    parser.add_argument('--dry-run', action='store_true',
                        help='Show what would be done without actually renaming')

    args = parser.parse_args()
    renamer = RenameFilesAsDate(args.directory)
    renamer.rename_files(args.type, args.dry_run)

if __name__ == '__main__':
    main()
