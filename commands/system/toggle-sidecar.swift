#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Toggle iPad Screen Mirroring (Automatic)
// @raycast.mode silent
//
// Optional parameters:
// @raycast.icon 🖥️
// @raycast.packageName Display
//
// Documentation:
// @raycast.description Automatically toggles your Mac's screen connection (Sidecar) to the first available iPad. Requires no additional modification. Based on the original script from Ocasio-J/SidecarLauncher.
// @raycast.author Marshal Fevzi
// @raycast.authorURL https://github.com/marshalfevzi

import Foundation

/// Runs a shell command and returns the standard output.
func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"

    do {
        try task.run()
    } catch {
        // This error is for the shell itself, not the command
        print("Shell Error: \(error.localizedDescription)")
        return ""
    }

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8) ?? ""
    return output
}

/// Checks if a Sidecar display is currently active.
func isSidecarConnected() -> Bool {
    let displayProfile = shell("system_profiler SPDisplaysDataType")
    return displayProfile.contains("Sidecar Display")
}

// --- Main Script Logic ---

// 1. Load the private SidecarCore framework
guard let _ = dlopen("/System/Library/PrivateFrameworks/SidecarCore.framework/SidecarCore", RTLD_LAZY) else {
    print("Error: Sidecar framework missing. Requires macOS 10.15+.")
    exit(1)
}

guard let cSidecarDisplayManager = NSClassFromString("SidecarDisplayManager") as? NSObject.Type else {
    print("Error: Could not find Sidecar manager.")
    exit(1)
}

guard let manager = cSidecarDisplayManager.perform(Selector(("sharedManager")))?.takeUnretainedValue() else {
    print("Error: Failed to start Sidecar manager.")
    exit(1)
}

// 2. Get the list of available devices
guard let devices = manager.perform(Selector(("devices")))?.takeUnretainedValue() as? [NSObject] else {
    print("Error: Failed to query for iPads.")
    exit(1)
}

// 3. Get connection status
let isConnected = isSidecarConnected()

// 4. Execute toggle logic
if isConnected {
    // --- DISCONNECT LOGIC ---
    guard let deviceToDisconnect = devices.first,
          let deviceName = deviceToDisconnect.perform(Selector(("name")))?.takeUnretainedValue() as? String else {

        print("Error: Connected, but can't find device to disconnect.")
        exit(1) // Ambiguous state
    }

    let dispatchGroup = DispatchGroup()
    let closure: @convention(block) (_ e: NSError?) -> Void = { e in
        defer { dispatchGroup.leave() }
        if let e = e {
            print("Error: Disconnect failed. \(e.localizedDescription)")
            exit(4)
        } else {
            print("Disconnected from \(deviceName)")
        }
    }

    dispatchGroup.enter()
    _ = manager.perform(Selector(("disconnectFromDevice:completion:")), with: deviceToDisconnect, with: closure)
    dispatchGroup.wait() // Wait for the async disconnect to finish

} else {
    // --- CONNECT LOGIC ---
    guard let deviceToConnect = devices.first,
          let deviceName = deviceToConnect.perform(Selector(("name")))?.takeUnretainedValue() as? String else {

        print("No iPad available to connect.")
        exit(2) // No reachable devices
    }

    let dispatchGroup = DispatchGroup()
    let closure: @convention(block) (_ e: NSError?) -> Void = { e in
        defer { dispatchGroup.leave() }
        if let e = e {
            print("Error: Connection failed. \(e.localizedDescription)")
            exit(4)
        } else {
            print("Connected to \(deviceName)")
        }
    }

    dispatchGroup.enter()
    _ = manager.perform(Selector(("connectToDevice:completion:")), with: deviceToConnect, with: closure)
    dispatchGroup.wait() // Wait for the async connect to finish
}

exit(0) // Success
