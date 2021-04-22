//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import TSCBasic
import TSCUtility

struct GitError: Error {
  let result: ProcessResult
}

struct GitShell {
  init() {}

  func run(_ args: String..., environment: [String: String] = Git.environment, path: AbsolutePath) throws -> String {
    do {
      return try execute(
        ["-C", path.dirname] + args,
        environment: environment
      )
    } catch {
      throw error
    }
  }

  private func execute(_ args: [String], environment: [String: String] = Git.environment) throws -> String {
    let process = Process(arguments: [Git.tool] + args, environment: environment)
    let result: ProcessResult

    do {
      try process.launch()
      result = try process.waitUntilExit()

      guard result.exitStatus == .terminated(code: 0) else {
        throw GitError(
          result: result
        )
      }

      let content = try result.utf8Output().spm_chomp()

      return content
    } catch let error as GitError {
      throw error
    } catch {
      let result = ProcessResult(
        arguments: process.arguments,
        environment: process.environment,
        exitStatus: .terminated(code: -1),
        output: .failure(error),
        stderrOutput: .failure(error)
      )

      throw GitError(
        result: result
      )
    }
  }
}
