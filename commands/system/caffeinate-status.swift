#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Caffeinate
// @raycast.mode inline
// @raycast.packageName System
// @raycast.refreshTime 30s
//
// Optional parameters:
// @raycast.icon ☕️
// @raycast.needsConfirmation false
//
// Documentation:
// @raycast.description Shows caffeinate status and time left if it's running
// @raycast.author Yan Smaliak
// @raycast.authorURL https://github.com/ysmaliak

import Foundation

func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/bash"
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}

func secondsToDhm(_ seconds: Int) -> (Int, Int, Int) {
    (seconds / 86400, (seconds % 86400) / 3600, (seconds % 3600) / 60)
}

let caffeinate_processes = shell("ps aux -O lstart | grep '\\d caffeinate'")

if caffeinate_processes.isEmpty {
    print("Caffeinate is not active")
    exit(0)
}

let formatter = DateFormatter()
formatter.dateFormat = "E MMM d HH:mm:ss yyyy"
let compactDateTimeFormatter = DateFormatter()
compactDateTimeFormatter.dateFormat = "MMM d, HH:mm"

let compactTimeFormatter = DateFormatter()
compactTimeFormatter.dateFormat = "HH:mm"

let currentDateTime = Date()
var maxDateTime: Date?
var latestStartDateTime: Date?

let separate_processes = caffeinate_processes.components(separatedBy: "\n")

separate_processes.forEach { process in
    let process_components = process
        .components(separatedBy: " ")
        .filter { !$0.isEmpty }
    
    if !process_components.isEmpty {
        let startDateTimeElements = [process_components[14], process_components[15], process_components[16], process_components[17], process_components[18]]
        let startDateTimeString = startDateTimeElements.joined(separator:" ")
        if let startDateTime = formatter.date(from: startDateTimeString), let timeInterval = Double(process_components[24]) {
            let endDateTime = startDateTime.addingTimeInterval(timeInterval)
            if let maxTimeToCompare = maxDateTime {
                if endDateTime > maxTimeToCompare {
                    maxDateTime = endDateTime
                    latestStartDateTime = startDateTime
                }
            } else {
                maxDateTime = endDateTime
                latestStartDateTime = startDateTime
            }
        } else {
            print("Something went wrong!")
            exit(1)
        }
    }
}

if let maxDateTime = maxDateTime, let latestStartDateTime = latestStartDateTime {
    let (d, h, m) = secondsToDhm(Int(maxDateTime - currentDateTime))
    let hmString: String = (d > 0 ? "\(d)d " : "") + (h > 0 ? "\(h)h " : "") + (m > 0 ? "\(m)m" : "")
    let calendar = Calendar.current
    let startDateTimeString = calendar.isDate(latestStartDateTime, inSameDayAs: currentDateTime) ?
        "at \(compactTimeFormatter.string(from: latestStartDateTime))" :
        "on \(compactDateTimeFormatter.string(from: latestStartDateTime))"
    print("Started \(startDateTimeString). Expires in \(hmString)")    
} else {
    print("Something went wrong!")
    exit(1)
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
