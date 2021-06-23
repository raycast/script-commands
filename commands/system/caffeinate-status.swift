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

let caffeinate_processes = shell("ps aux | grep '\\d caffeinate'")

if caffeinate_processes.isEmpty {
    print("Caffeinate is not active")
    exit(0)
}

let formatter = DateFormatter()
formatter.dateFormat = "h:mma"
let utcFromatter = formatter.copy() as! DateFormatter
utcFromatter.timeZone = TimeZone(abbreviation: "UTC")

let currentTime = Date()
var maxTime: Date?

let separate_processes = caffeinate_processes.components(separatedBy: "\n")

separate_processes.forEach { process in
    let process_components = process
        .components(separatedBy: " ")
        .filter { !$0.isEmpty }
        
    if !process_components.isEmpty {
        if let startTime = utcFromatter.date(from: process_components[8]),
           let timeInterval = Double(process_components[12]) {
               let endTime = startTime.addingTimeInterval(timeInterval)
               if let maxTimeToCompare = maxTime {
                    if endTime > maxTimeToCompare {
                        maxTime = endTime
                    }
               } else {
                   maxTime = endTime
               }
        } else {
            print("Something went wrong!")
            exit(1)
        }
    }
}

let currentTimeString = formatter.string(from: currentTime)
let currentTimeFromFormatter = utcFromatter.date(from: currentTimeString)

if let maxTime = maxTime, let currentTimeFromFormatter = currentTimeFromFormatter {
    let (d, h, m) = secondsToDhm(Int(maxTime - currentTimeFromFormatter))
    let hmString: String = (d > 0 ? "\(d)d " : "") + (h > 0 ? "\(h)h " : "") + (m > 0 ? "\(m)m" : "")
    print("Caffeinate is running. Time left: \(hmString)")
} else {
    print("Something went wrong!")
    exit(1)
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
