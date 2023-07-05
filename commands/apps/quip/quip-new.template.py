#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title {{commandtitle}}
# @raycast.mode compact

# Optional parameters:
# @raycast.icon /Applications/Quip.app/Contents/Resources/AppIcon.icns
# @raycast.argument1 { "type": "text", "placeholder": "{{commandargplaceholder}}", "optional": {{opendocifemptyarg}} }
# @raycast.packageName Quip utilities

# Documentation:
# @raycast.description Configure your Quip API token and other defaults in quip_config.ini
# @raycast.author zzamboni
# @raycast.authorURL https://raycast.com/zzamboni

import sys
import re
import quip_utils

# Determine the document type to create from the script filename.
match = re.search('quip-new-(.+)\.py', sys.argv[0])
if match:
    doc_type = match.group(1)
    if len(sys.argv) > 1:
        arg = sys.argv[1]
    else:
        arg = None
    quip_utils.quip_new_doc(doc_type, arg)
else:
    quip_utils.fail(f"Error: Could not determine document type to use - incorrect script name.")
