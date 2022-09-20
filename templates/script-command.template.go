//usr/bin/env go run "$0" "$@"; exit "$?"

// Raycast Script Command Template
// Duplicate this file and remove ".template." from the filename to get started.
// See full documentation here: https://github.com/raycast/script-commands
//
// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title My First Script
// @raycast.mode fullOutput
// @raycast.packageName Raycast Scripts
//
// Optional parameters:
// @raycast.icon 🤖
// @raycast.currentDirectoryPath ~
// @raycast.needsConfirmation false
//
// Documentation:
// @raycast.description Write a nice and descriptive summary about your script command here
// @raycast.author Your name
// @raycast.authorURL An URL for one of your social medias

package main

import "fmt"

func main() {
	fmt.Println("Hello from My First Script")
}
