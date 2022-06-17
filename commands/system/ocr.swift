#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title ocr
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🖼
// @raycast.packageName OCR_SWIFT

// Documentation:
// @raycast.author zhe
// @raycast.authorURL https://github.com/wmszhe
// @raycast.description OCR with macOS Vision

import Foundation
import CoreImage
import Cocoa
import Vision

let tmpPath = "/tmp/ocr.png"
var recognitionLanguages = ["en-US", "zh-CN"]
var joiner = " "


func doShell(_ command: String) -> String {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String

    return output
}

func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
    let context = CIContext(options: nil)
    if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
        return cgImage
    }
    return nil
}

func paste(text: String) {
    let pasteboard = NSPasteboard.general
    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.clearContents()
    pasteboard.setString(text, forType: .string)
}

func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard let observations =
    request.results as? [VNRecognizedTextObservation] else {
        return
    }
    let recognizedStrings = observations.compactMap { observation in
        // Return the string of the top VNRecognizedText instance.
        observation.topCandidates(1).first?.string
    }

    // Process the recognized strings.
    let result = recognizedStrings.joined(separator: joiner)

    print("result: " + result)

    paste(text: result)
}

func detectText(fileName: URL) -> [String]? {
    if let ciImage = CIImage(contentsOf: fileName) {
        guard let img = convertCIImageToCGImage(inputImage: ciImage) else {
            return nil
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
    return nil
}

func recognitionQRCode(fileName: URL) -> Bool {
    let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)

    guard let ciImage = CIImage(contentsOf: fileName) else {
        return false
    }

    guard let features = detector?.features(in: ciImage) else {
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
        paste(text: result)
    }

    return isQRCode
}

func main() {
    // Only support the system above macOS 10.15
    guard #available(OSX 10.15, *) else {
        print("Only support the system above macOS 10.15")
        return
    }
    let _ = doShell("/usr/sbin/screencapture -i " + tmpPath)
    guard recognitionQRCode(fileName: URL(fileURLWithPath: tmpPath)) else {
        let _ = detectText(fileName: URL(fileURLWithPath: tmpPath))
        return
    }
}

main()

