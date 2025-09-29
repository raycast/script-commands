#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Copy Meeting Summary
// @raycast.mode silent
// @raycast.packageName System
//
// Optional parameters:
// @raycast.icon 📝
//
// Documentation:
// @raycast.description Copies a summary of today's meetings to the clipboard.

import AppKit
import EventKit

let now = Date()
let calendar: Calendar = .current

do {
  let today: (startDate: Date, endDate: Date, events: [EKEvent])

  do {
    // Retrieve the range for today (from 00:00 to 23:59)
    today.startDate = calendar.startOfDay(for: now)
    today.endDate = calendar.date(byAdding: .day, value: 1, to: today.startDate)!
    
    // Retrieve all the events for today
    let store = EKEventStore()
    let predicate = store.predicateForEvents(withStart: today.startDate, end: today.endDate, calendars: nil)
    today.events = store.events(matching: predicate)
      .filter { !$0.isAllDay } // Exclude all-day events
      .sorted { $0.startDate < $1.startDate } // Sort by start time
  }

  let summary: String
  if today.events.isEmpty {
    summary = "No meetings scheduled for today."
  } else {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .none
    let todayString = dateFormatter.string(from: now)
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    timeFormatter.timeZone = TimeZone.current
    
    let meetingList = today.events.map { event in
      let startTime = timeFormatter.string(from: event.startDate)
      let title = event.title ?? "Untitled Event"
      let timezone = timeFormatter.timeZone.abbreviation() ?? ""
      
      var meetingInfo = timezone.isEmpty ? "• \(startTime): \(title)" : "• \(startTime) \(timezone): \(title)"
      
      // Add location if available
      if let location = event.location, !location.isEmpty {
        meetingInfo += " (\(location))"
      }
      
      // Add notes if available (first line only to keep it concise)
      if let notes = event.notes, !notes.isEmpty {
        let firstLine = notes.components(separatedBy: .newlines).first ?? ""
        let cleanedNotes = firstLine.trimmingCharacters(in: .whitespacesAndNewlines)
        // Filter out junk characters (like the -::~: pattern)
        let validNotes = cleanedNotes.filter { char in
          char.isLetter || char.isNumber || char.isWhitespace || char.isPunctuation && !"-:~".contains(char)
        }
        if !validNotes.isEmpty && validNotes.count <= 100 && !validNotes.allSatisfy({ "-:~".contains($0) }) {
          meetingInfo += "\n  Notes: \(String(validNotes))"
        }
      }
      
      return meetingInfo
    }.joined(separator: "\n")
    
    let meetingCount = today.events.count
    
    summary = """
Meetings:
\(meetingList)
"""
  }

  NSPasteboard.general.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
  NSPasteboard.general.setString(summary, forType: NSPasteboard.PasteboardType.string)
  print("Copied meeting summary to clipboard")
} catch {
  print("Error retrieving calendar events: \(error)")
}