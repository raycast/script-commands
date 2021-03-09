#!/usr/bin/ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Running processes
# @raycast.mode fullOutput
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🔡
# @raycast.argument3 { "type": "text", "placeholder": "Count (15)", "optional": true }

# Documentation:
# @raycast.description List running processes
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

# Adapted from https://github.com/ngreenstein/alfred-process-killer

items = []
count = ARGV[0] == "" || ARGV[0] == nil ? "15" : ARGV[0]

# Assemble an array of each matching process. It will contain the process's path and percent CPU usage.
# The -A flag shows all processes. The -o pid, -o %cpu, and -o comm show only the process's PID, CPU usage and path, respectively.
# Grep for processes whose name contains the query. The regex isolates the name by only searching characters after the last slash in the path.
#  The -i flag ignores case.

processes = `ps -A -o pid -o %cpu -o comm | grep -i [^/]*[^/]*$ | sort -nrk 2,3 | head -n #{count}`.split("\n")

processes.each do |process|
	# Extract the PID, CPU usage, and path from the line (lines are in the form of `123 12.3 /path/to/process`).
	processId, processCpu, processPath = process.match(/(\d+)\s+(\d+[\.|\,]\d+)\s+(.*)/).captures
	# If an argument filter has been specified, get the arguments and search for the filter.

	# Use the same expression as before to isolate the name of the process.
	processName = processPath.match(/[^\/]*[^\/]*$/i)[0]

	items.push(processCpu + "% @ " + processName + " (" + processId + ")")
end

puts items.join("\n")
