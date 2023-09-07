#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Selfie
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon 🤖
// @raycast.packageName Vanity

// Documentation:
// @raycast.description Takes a selfie and copies it to the clipboard
// @raycast.author michaeljelly
// @raycast.authorURL https://raycast.com/michaeljelly

//
//  SelfieApp.swift
//  Selfie
//
//  Created by Michael Jelly on 07/09/2023.
//

import AVFoundation
import AppKit
import SwiftUI

class SelfieTaker: NSObject, AVCapturePhotoCaptureDelegate {
  let session = AVCaptureSession()
  let output = AVCapturePhotoOutput()

  override init() {
    super.init()
    print("thing")
    guard
      let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    else { return }
    print("inp")
    guard let input = try? AVCaptureDeviceInput(device: device) else { return }

    session.addInput(input)
    session.addOutput(output)
    session.startRunning()
    let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
    print("try")

    DispatchQueue.main.asyncAfter(
      deadline: .now() + 0.3,
      execute: { [self] in
        print("ar")
        self.output.capturePhoto(with: settings, delegate: self)
        print("Captured")
      })

  }

  func photoOutput(
    _ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?
  ) {
    print("photo")
    guard let imageData = photo.fileDataRepresentation(),
      let image = NSImage(data: imageData)
    else {
      print("nodata")
      return
    }

    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    print("cleared")
    pasteboard.writeObjects([image])
    print("copied")

    session.stopRunning()
    CFRunLoopStop(CFRunLoopGetCurrent())
  }
}

let selfieTaker = SelfieTaker()
CFRunLoopRun()
