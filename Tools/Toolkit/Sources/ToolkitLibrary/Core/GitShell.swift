//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

// MARK: - GitError

struct GitError: Error {
  let description: String
}

// MARK: - GitShell

struct GitShell {
  func run(_ args: String..., path: URL) async throws -> String {
    try await withCheckedThrowingContinuation { continuation in
      let process = Process()
      process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
      process.arguments = ["-C", path.deletingLastPathComponent().path] + args

      var environment = ProcessInfo.processInfo.environment
      environment["GIT_TERMINAL_PROMPT"] = "0"
      process.environment = environment

      let stdoutPipe = Pipe()
      let stderrPipe = Pipe()
      process.standardOutput = stdoutPipe
      process.standardError = stderrPipe

      process.terminationHandler = { proc in
        let data = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)?
          .trimmingCharacters(in: .newlines) ?? ""

        if proc.terminationStatus == 0 {
          continuation.resume(returning: output)
        } else {
          continuation.resume(
            throwing: GitError(
              description: "git exited with status \(proc.terminationStatus)",
            ),
          )
        }
      }

      do {
        try process.run()
      } catch {
        continuation.resume(throwing: error)
      }
    }
  }
}
