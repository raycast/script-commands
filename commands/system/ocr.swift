#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title OCR
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🖼
// @raycast.packageName Productivity

// Documentation:
// @raycast.author zhe
// @raycast.authorURL https://github.com/wmszhe
// @raycast.description Use macOS Vision API Identification pictures, if it contain a QR code, Copy the QR code content to the clipboard, If do not include QR codes, identify text content and supplement to clipboard


import Foundation
import CoreImage
import Cocoa
import Vision

let screenCapturePath = "/tmp/ocr.png"
let recognitionLanguages = ["zh-Hans", "en-US"]
let joiner = " "

@discardableResult
func screenCapture(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()

    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]
    task.standardOutput = pipe
    task.standardError = pipe

    try task.run()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        return output
    } else {
        throw NSError(domain: "error", code: -1, userInfo: nil)
    }
}

func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
    let context = CIContext(options: nil)
    return context.createCGImage(inputImage, from: inputImage.extent)
}

func paste(text: String) {
    let pasteboard = NSPasteboard.general
    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.clearContents()
    pasteboard.setString(text, forType: .string)
}

func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard let observations = request.results as? [VNRecognizedTextObservation] else {
        return
    }
    let recognizedStrings = observations.compactMap { observation in
        // Return the string of the top VNRecognizedText instance.
        observation.topCandidates(1).first?.string
    }

    // Process the recognized strings.
    let result = recognizedStrings.joined(separator: joiner)

    print("The text content is: " + result)

    paste(text: result)
}

func detectText(fileName: URL) {
    guard
            let ciImage = CIImage(contentsOf: fileName),
            let img = convertCIImageToCGImage(inputImage: ciImage)
    else {
        return
    }

    let requestHandler = VNImageRequestHandler(cgImage: img)

    // Create a new request to recognize text.
    let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
    request.recognitionLanguages = recognitionLanguages

    do {
        // Perform the text-recognition request.
        try requestHandler.perform([request])
    } catch {
        print("Unable to perform the requests: \(error).")
    }
}

func detectImage(fileName: URL) -> Bool {
    let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)

    guard let ciImage = CIImage(contentsOf: fileName), let features = detector?.features(in: ciImage) else {
        return false
    }

    var isQRCode = false
    var result = ""
    for feature in features as! [CIQRCodeFeature] {
        if feature.type == "QRCode" {
            isQRCode = true
        }
        result += feature.messageString ?? ""
        result += "\n"
    }

    if isQRCode {
        print("QR code analysis results: " + result)
        paste(text: result)
    }

    return isQRCode
}

func main() {
    // Only support the system above macOS 10.15
    guard #available(OSX 10.15, *) else {
        return print("Only support the system above macOS 10.15")
    }
    do {
        // It must be ensured that the screenshot is preserved successfully
        try screenCapture("/usr/sbin/screencapture -i " + screenCapturePath)
        print("screen capture complete, Image preservation location: " + screenCapturePath)
    } catch {
        return print("\(error)")
    }

    // Determine whether the picture contains a QR code, if it contain a QR code, Copy the QR code content to the clipboard
    guard detectImage(fileName: URL(fileURLWithPath: screenCapturePath)) else {
        // If do not include QR codes, identify text content and supplement to clipboard
        return detectText(fileName: URL(fileURLWithPath: screenCapturePath))
    }
}

main()
