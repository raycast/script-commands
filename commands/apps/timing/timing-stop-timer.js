#!/usr/bin/osascript -l JavaScript

// Note: Timing.app is required with an Expert or Connect subscription
// Learn more and install: https://timingapp.com

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Stop Timer
// @raycast.mode silent

// Optional parameters:
// @raycast.icon images/timing-logo.png
// @raycast.packageName Timing

// Documentation:
// @raycast.description Stop the active timer
// @raycast.author Landen Danyluk
// @raycast.authorURL https://github.com/landendanyluk

function run() {
    const timing = Application('TimingHelper');

    // throw if AppleScript support is not enabled
    if (!timing.scriptingSupportAvailable()) {
        console.log('Scripting support requires an Expert or Connect subscription');
        throw new Error();
    }

    timing.stopCurrentTimer({ notification: true });
}
