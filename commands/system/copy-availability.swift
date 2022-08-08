#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Copy Availability
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 📅
// @raycast.argument1 { "type": "text", "placeholder": "9:00", "optional": true }
// @raycast.argument2 { "type": "text", "placeholder": "17:00", "optional": true }
//
// Documentation:
// @raycast.description Copies the calendar availability of today.

import AppKit
import EventKit

let now = Date()
let calendar: Calendar = .current

do {
  let workDay: (startDate: Date, endDate: Date)
  let today: (startDate: Date, endDate: Date, events: [EKEvent])

  do {
    // Retrieve the range for today (from 00:00 to 23:59)
    today.startDate = calendar.startOfDay(for: now)
    today.endDate = calendar.date(byAdding: .day, value: 1, to: today.startDate)!
    // Parse the optional arguments
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    var arguments = try CommandLine.arguments.dropFirst().prefix(2).map { arg throws -> Date? in
      var iterator = arg.split(separator: ":").makeIterator()
      guard let hours = iterator.next() else { return nil }
      let minutes = iterator.next() ?? "00"
      guard hours.allSatisfy(\.isNumber),
            minutes.allSatisfy(\.isNumber),
            let date = timeFormatter.date(from: "\(hours):\(minutes)") else { throw Error.invalidInput(arg) }
      return date
    }.makeIterator()
    // Compose the working day range (checking that start is not after end)
    workDay.startDate = arguments.next().flatMap { $0 } ?? calendar.date(bySettingHour: 9, minute: 0, second: 0, of: now)!
    workDay.endDate = arguments.next().flatMap { $0 } ?? calendar.date(bySettingHour: 17, minute: 0, second: 0, of: now)!
    guard workDay.startDate < workDay.endDate else { throw Error.invalidRange }
    // Retrieve all the events for today
    let store = EKEventStore()
    let predicate = store.predicateForEvents(withStart: today.startDate, end: today.endDate, calendars: nil)
    today.events = store.events(matching: predicate).filter { !$0.isAllDay }
  }

  let availability: String
  if today.events.isEmpty {
    availability = "I'm available the full day."
  } else if calendar.component(.hour, from: now) < 12,
            today.events.allSatisfy({ calendar.component(.hour, from: $0.endDate) >= 12 }) {
    availability = "I'm available in the morning."
  } else if today.events.allSatisfy({ calendar.component(.hour, from: $0.endDate) <= 11 }) {
    availability = "I'm available in the afternoon."
  } else {
    let allowedRange = workDay.startDate...workDay.endDate
    let busy = busyRanges(during: allowedRange, events: today.events)
    let available = availableRanges(during: allowedRange, busy: busy)
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    let availableTimes = available
      .map { (from: timeFormatter.string(from: $0.lowerBound), to: timeFormatter.string(from: $0.upperBound)) }
      .map { "- \($0.from) - \($0.to)" }
      .joined(separator: "\n")
    availability = "Here's my availability for today:\n\(availableTimes)"
  }

  NSPasteboard.general.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
  NSPasteboard.general.setString(availability, forType: NSPasteboard.PasteboardType.string)
  print("Copied availability")
} catch Error.invalidInput(let arg) {
  print("Invalid date input: '\(arg)'")
} catch Error.invalidRange {
  print("The input date range is invalid")
} catch {
  print("Unknown error.")
}


// MARK: - Convenience

private enum Error: Swift.Error {
  case invalidInput(String)
  case invalidRange
}

private func busyRanges(during allowedRange: ClosedRange<Date>, events: [EKEvent]) -> [ClosedRange<Date>] {
  let busyRanges = events
    .compactMap { $0.startDate...$0.endDate }
    .sorted(by: { $0.lowerBound < $1.lowerBound })

  var result: [ClosedRange<Date>] = []
  for busy in busyRanges.sorted(by: { $0.lowerBound < $1.lowerBound }) {
    guard busy.upperBound > allowedRange.lowerBound,
          busy.lowerBound < allowedRange.upperBound else { continue }

    let start = max(busy.lowerBound, allowedRange.lowerBound)
    let end = min(busy.upperBound, allowedRange.upperBound)
    guard start < end else { continue }

    guard let last = result.last else {
      result.append(start...end)
      continue
    }

    if start > last.upperBound {
      result.append(start...end)
    } else {
      result[result.endIndex - 1] = min(start, last.lowerBound)...max(end, last.upperBound)
    }
  }

  return result
}

private func availableRanges(during allowedRange: ClosedRange<Date>, busy busyRanges: [ClosedRange<Date>]) -> [ClosedRange<Date>] {
  var result: [ClosedRange<Date>] = []
  var milestone: Date = allowedRange.lowerBound

  for busy in busyRanges {
    if busy.lowerBound > milestone {
      result.append(milestone...busy.lowerBound)
    }
    milestone = busy.upperBound
  }

  if milestone < allowedRange.upperBound {
    result.append(milestone...allowedRange.upperBound)
  }

  return result
}
