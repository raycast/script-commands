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

# Assemble an array of each matching process.
# -e shows all processes, -c shows only the executable name.
# The pid, pcpu, and comm show only the process's PID, CPU usage and path, respectively.

processes = `ps -eo pid,pcpu,comm | sort -nrk 2,3 | head -n #{count}`.split("\n")

processes.each do |process|
	# Extract the PID, CPU usage, and path from the line (lines are in the form of `123 12.3 /path/to/process`).
	processId, processCpu, processPath = process.match(/(\d+)\s+(\d+[\.|\,]\d+)\s+(.*)/).captures

	# Isolate the name of the process.
	processName = processPath.match(/[^\/]*[^\/]*$/i)[0]

	items.push(processCpu + "% @ " + processName + " (" + processId + ")")
end

puts items.join("\n")
