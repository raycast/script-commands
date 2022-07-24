#!/usr/bin/osascript -l JavaScript

// Note: Timing.app is required with an Expert or Connect subscription
// Learn more and install: https://timingapp.com

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Start Timer
// @raycast.mode silent

// Optional parameters:
// @raycast.icon images/timing-logo.png
// @raycast.argument1 { "type": "text", "placeholder": "Project", "optional": true }
// @raycast.argument2 { "type": "text", "placeholder": "Title", "optional": true }
// @raycast.argument3 { "type": "text", "placeholder": "Duration", "optional": true }
// @raycast.packageName Timing

// Documentation:
// @raycast.description Start a timer
// @raycast.author Landen Danyluk
// @raycast.authorURL https://github.com/landendanyluk

function run(argv) {
    const timing = Application('TimingHelper');

    // throw if AppleScript support is not enabled
    if (!timing.scriptingSupportAvailable()) {
        console.log('Scripting support requires an Expert or Connect subscription');
        throw new Error();
    }

    // throw if both project and title are empty
    if (!(argv[0] || argv[1])) {
        console.log("Please enter a project name or title");
        throw new Error();
    }

    let project;
    if (argv[0] !== "") {
        // check if project exists
        const projects = timing.projects.whose({ name: argv[0] });
        if (!projects.length) {
            console.log("Project does not exist");
            throw new Error();
        } else {
            // if there's more than one project with the same name, choose the first one in the list
            project = projects[0];
        }
    }
    const withTitle = argv[1];
    const forAbout = Number(argv[2]) * 60;
    if (isNaN(forAbout)) {
        console.log("Please enter a valid duration");
        throw new Error();
    }

    // JXA will complain if a key is present but undefined, so we have to add them like this
    const options = {};
    if (project) {
        options.project = project;
    }
    if (withTitle) {
        options.withTitle = withTitle;
    }
    if (forAbout) {
        options.forAbout = forAbout;
    }

    timing.startTimer(options);
}
