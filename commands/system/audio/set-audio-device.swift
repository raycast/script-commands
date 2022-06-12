#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Set audio device
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🎧
// @raycast.argument1 { "type": "text", "placeholder": "Name" }
// @raycast.argument2 { "type": "text", "placeholder": "Type (i/o/b)", "optional": true }
// @raycast.packageName Audio

// Documentation:
// @raycast.description Sets the input (i), the output (o) or both (b) audio sources, based on name. If `both` is passed, but no input or output device is found with the given name, it will still try to set the other one. For example, if you're trying to set both to "External mic", which doesn't have an input source, it will still set the output to the mic; vice-versa for a speaker.
// @raycast.author Roland Leth
// @raycast.authorURL https://runtimesharks.com

// Change lines 29 and 30 if you'd like another default,
// which currently sets both when no parameter is passed.

let arguments = Array(CommandLine.arguments.dropFirst())
let query = arguments.first!
let changeType: DeviceType = arguments.count >= 2
	? ["input", "i"].contains(arguments[1])
		? .input
		: ["output", "o"].contains(arguments[1])
			? .output
			: .both
	: .both

import Foundation
import CoreAudio

// Based on https://stackoverflow.com/a/58618034/793916

// Equivalent of kAudioObjectPropertyElementMain to prevent SDK compatibility issues.
private let audioObjectPropertyElementMain: AudioObjectPropertyElement = 0

struct DeviceType: OptionSet {

	static let input = DeviceType(rawValue: 1 << 0)
	static let output = DeviceType(rawValue: 1 << 1)
	static let both: DeviceType = [.input, .output]

	let rawValue: Int

	var value: String {
		switch self {
		case .input:
			return "input"
		case .output:
			return "output"
		case .both:
			return "both"
		default:
			return ""
		}
	}

}

final class AudioDevice {

	let audioDeviceID: AudioDeviceID

	init(deviceID: AudioDeviceID) {
		self.audioDeviceID = deviceID
	}

	var hasOutput: Bool {
		var address = AudioObjectPropertyAddress(
			mSelector: AudioObjectPropertySelector(kAudioDevicePropertyStreamConfiguration),
			mScope: AudioObjectPropertyScope(kAudioDevicePropertyScopeOutput),
			mElement: audioObjectPropertyElementMain)

		var propSize = UInt32(MemoryLayout<CFString?>.size)
		var result = AudioObjectGetPropertyDataSize(audioDeviceID, &address, 0, nil, &propSize)

		if (result != 0) {
			return false
		}

		let bufferList = UnsafeMutablePointer<AudioBufferList>.allocate(capacity: Int(propSize))

		defer {
			bufferList.deallocate()
		}

		result = AudioObjectGetPropertyData(audioDeviceID, &address, 0, nil, &propSize, bufferList)

		if (result != 0) {
			return false
		}

		let buffers = UnsafeMutableAudioBufferListPointer(bufferList)

		return buffers.contains { $0.mNumberChannels > 0 }
	}

	var name: String? {
		var address = AudioObjectPropertyAddress(
			mSelector: AudioObjectPropertySelector(kAudioObjectPropertyName),
			mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
			mElement: audioObjectPropertyElementMain)

		var name: CFString? = nil
		var propSize = UInt32(MemoryLayout<CFString?>.size)
		let result = AudioObjectGetPropertyData(audioDeviceID, &address, 0, nil, &propSize, &name)

		if (result != 0) {
			return nil
		}

		return name as String?
	}

}

func findDevices() -> [AudioDevice] {
	var propSize: UInt32 = 0

	var address = AudioObjectPropertyAddress(
		mSelector: AudioObjectPropertySelector(kAudioHardwarePropertyDevices),
		mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
		mElement: audioObjectPropertyElementMain)

	var result = AudioObjectGetPropertyDataSize(
		AudioObjectID(kAudioObjectSystemObject),
		&address,
		0,
		nil,
		&propSize)

	if (result != 0) {
		print("Error \(result) from AudioObjectGetPropertyDataSize")
		return []
	}

	let numDevices = Int(propSize / UInt32(MemoryLayout<AudioDeviceID>.size))
	var devids = Array<AudioDeviceID>(repeating: AudioDeviceID(), count: numDevices)

	result = AudioObjectGetPropertyData(
		AudioObjectID(kAudioObjectSystemObject),
		&address,
		0,
		nil,
		&propSize,
		&devids)

	if (result != 0) {
		print("Error \(result) from AudioObjectGetPropertyData")
		return []
	}

	return (0..<numDevices).compactMap { i in
		AudioDevice(deviceID: devids[i])
	}

}

@discardableResult
func set(_ deviceType: DeviceType, to query: String) -> (Bool, String) {
	let devices = findDevices()

	guard
		let device = devices.first(where: {
			$0.name?.localizedCaseInsensitiveContains(query) == true
				 && (deviceType.contains(.input) ? !$0.hasOutput : $0.hasOutput)
		})
	else {
		return (false, query)
	}

	let deviceName = device.name ?? query
	var deviceId = device.audioDeviceID
	let deviceIdSize = UInt32(MemoryLayout.size(ofValue: deviceId))
	let selector = deviceType.contains(.input)
		? kAudioHardwarePropertyDefaultInputDevice
		: kAudioHardwarePropertyDefaultOutputDevice

	var deviceIdPropertyAddress = AudioObjectPropertyAddress(
		mSelector: AudioObjectPropertySelector(selector),
		mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
		mElement: audioObjectPropertyElementMain)

	let result = AudioObjectSetPropertyData(
		AudioObjectID(kAudioObjectSystemObject),
		&deviceIdPropertyAddress,
		0,
		nil,
		deviceIdSize,
		&deviceId)

	if (result != 0) {
		return (false, deviceName)
	}

	return (true, deviceName)
}

switch changeType {
case .input,
	 .output:
	let  i = set(changeType, to: query)

	guard i.0 else {
		print("Could not set \(changeType.value) to \(i.1)")
		exit(1)
	}

	print("Set \(changeType.value) to \(i.1)")
case .both:
	let i = set(.input, to: query)
	let o = set(.output, to: query)

	switch (i.0, o.0) {
	case (false, false):
		print("Could not set any device to \(i.1)")
	case (true, false):
		print("Set input to \(i.1)")
	case (false, true):
		print("Set output to \(i.1)")
	case (true, true):
		print("Set both to \(i.1) & \(o.1)")
	}
default:
	exit(1)
}
