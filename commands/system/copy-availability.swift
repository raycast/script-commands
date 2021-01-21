#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Copy Availability
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 📅
//
// Documentation:
// @raycast.description Copies the calendar availability of today.

import AppKit
import EventKit

// MARK: - Main

let now = Date()
let startOfToday = Calendar.current.startOfDay(for: now)
let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday)!

let eventStore = EKEventStore()
let predicate = eventStore.predicateForEvents(withStart: startOfToday, end: endOfToday, calendars: nil)
let eventsOfToday = eventStore.events(matching: predicate).filter { !$0.isAllDay }

let availability: String
if eventsOfToday.isEmpty {
  availability = "I'm available the full day."
} else if eventsOfToday.allSatisfy({ $0.endDate.isAfternoon }) {
  availability = "I'm available in the morning."
} else if eventsOfToday.allSatisfy({ $0.endDate.isMorning }) {
  availability = "I'm available in the afternoon."
} else {
  let busyTimes = eventsOfToday.map { $0.startDate...$0.endDate }
  
  let availableTimes = getAvailableTimesForToday(excluding: busyTimes)
  let prettyPrintedAvailableTimes = availableTimes
    .map { (from: DateFormatter.shortTime.string(from: $0.lowerBound), to: DateFormatter.shortTime.string(from: $0.upperBound)) }
    .map { "- \($0.from) - \($0.to)" }
    .joined(separator: "\n")

  availability = "Here's my availability for today:\n\(prettyPrintedAvailableTimes)"
}

copy(availability)
print("Copied availability")

// MARK: - Convenience

extension DateFormatter {
  static var shortTime: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    return dateFormatter
  }
}

extension Date {
  var isMorning: Bool { Calendar.current.component(.hour, from: self) <= 11 }
  var isAfternoon: Bool { Calendar.current.component(.hour, from: self) >= 12 }
}

func getAvailableTimesForToday(excluding excludedTimes: [ClosedRange<Date>]) -> [ClosedRange<Date>] {
  let startOfWorkDay = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: startOfToday)!
  let endOfWorkDay = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: startOfToday)!
  let workDay = startOfWorkDay...endOfWorkDay

  let busyTimes = [startOfToday...startOfWorkDay] + excludedTimes + [endOfWorkDay...endOfToday]
  var previousBusyTime = busyTimes.first
  var availableTimes = [ClosedRange<Date>]()
  for time in busyTimes {
    if let previousEnd = previousBusyTime?.upperBound, previousEnd < time.lowerBound {
      var newAvailability = previousEnd...time.lowerBound
      if let lastAvailability = availableTimes.last, newAvailability.overlaps(lastAvailability) {
        newAvailability = newAvailability.clamped(to: lastAvailability).clamped(to: workDay)
        availableTimes.insert(newAvailability, at: availableTimes.count - 1)
      } else {
        newAvailability = newAvailability.clamped(to: workDay)
        availableTimes.append(newAvailability)
      }
    }
    previousBusyTime = time
  }

  return availableTimes
}

func copy(_ string: String) {
  NSPasteboard.general.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
  NSPasteboard.general.setString(string, forType: NSPasteboard.PasteboardType.string)
}
