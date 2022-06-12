#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Audio devices
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon 🔈
// @raycast.packageName Audio

// Documentation:
// @raycast.description Lists all audio devices
// @raycast.author Roland Leth
// @raycast.authorURL https://runtimesharks.com

import Foundation
import CoreAudio

// Based on https://stackoverflow.com/a/58618034/793916

// Equivalent of kAudioObjectPropertyElementMain to prevent SDK compatibility issues.
private let audioObjectPropertyElementMain: AudioObjectPropertyElement = 0

final class AudioDevice {

	let audioDeviceID: AudioDeviceID

	init(deviceID: AudioDeviceID) {
		self.audioDeviceID = deviceID
	}

	var hasOutput: Bool {
		var address: AudioObjectPropertyAddress = AudioObjectPropertyAddress(
			mSelector: AudioObjectPropertySelector(kAudioDevicePropertyStreamConfiguration),
			mScope: AudioObjectPropertyScope(kAudioDevicePropertyScopeOutput),
			mElement: audioObjectPropertyElementMain)

		var propSize: UInt32 = 0
		var result = AudioObjectGetPropertyDataSize(
			audioDeviceID,
			&address,
			0,
			nil,
			&propSize)

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
	var address = AudioObjectPropertyAddress(
		mSelector: AudioObjectPropertySelector(kAudioHardwarePropertyDevices),
		mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
		mElement: audioObjectPropertyElementMain)

	var propSize: UInt32 = 0
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

let devices = findDevices()
let inputs = devices.filter { !$0.hasOutput }
let outputs = devices.filter { $0.hasOutput }

func selectedDevice(output: Bool) -> String? {
	var id = AudioObjectID(kAudioObjectSystemObject)
	var idSize = UInt32(MemoryLayout.size(ofValue: id))
	let selector = output
		? kAudioHardwarePropertyDefaultOutputDevice
		: kAudioHardwarePropertyDefaultInputDevice

	var idPropertyAddress = AudioObjectPropertyAddress(
		mSelector: AudioObjectPropertySelector(selector),
		mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
		mElement: audioObjectPropertyElementMain)

	let result = AudioObjectGetPropertyData(
		id,
		&idPropertyAddress,
		0,
		nil,
		&idSize,
		&id)

	if (result != 0) {
		return nil
	}

	return (output ? outputs : inputs).first { $0.audioDeviceID == id }?.name
}

let outputDevice = selectedDevice(output: true)
let inputDevice = selectedDevice(output: false)

let inputNames = inputs
	.compactMap(\.name)
	.map { inputDevice == $0 ? "* \($0)" : $0 }
	.sorted()
	.joined(separator: "\n")
let outputNames = outputs
	.compactMap(\.name)
	.map { outputDevice == $0 ? "* \($0)" : $0 }
	.sorted()
	.joined(separator: "\n")

print("Inputs:\n\(inputNames)\n\nOutputs:\n\(outputNames)")
