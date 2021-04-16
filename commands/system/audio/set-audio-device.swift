#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Set audio device
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🎧
// @raycast.argument1 { "type": "text", "placeholder": "Name" }
// @raycast.argument2 { "type": "text", "placeholder": "Input (y/n)", "optional": true }
// @raycast.packageName Audio

// Documentation:
// @raycast.description Sets an input or output audio device, based on name
// @raycast.author Roland Leth
// @raycast.authorURL https://runtimesharks.com

import Foundation
import CoreAudio

// Based on https://stackoverflow.com/a/58618034/793916

final class AudioDevice {

	let audioDeviceID: AudioDeviceID

	init(deviceID: AudioDeviceID) {
		self.audioDeviceID = deviceID
	}

	var hasOutput: Bool {
		var address = AudioObjectPropertyAddress(
			mSelector: AudioObjectPropertySelector(kAudioDevicePropertyStreamConfiguration),
			mScope: AudioObjectPropertyScope(kAudioDevicePropertyScopeOutput),
			mElement: AudioObjectPropertyElement(0))

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
			mSelector: AudioObjectPropertySelector(kAudioDevicePropertyDeviceNameCFString),
			mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
			mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))

		var name: CFString? = nil
		var propSize = UInt32(MemoryLayout<CFString?>.size)
		let result = AudioObjectGetPropertyData(audioDeviceID, &address, 0, nil, &propSize, &name)

		if (result != 0) {
			return nil
		}

		return name as String?
	}

}

let arguments = Array(CommandLine.arguments.dropFirst())
let query = arguments.first!
let shouldChangeInput = arguments.count >= 2 && ["yes", "y", "true"].contains(arguments[1])

func findDevices() -> [AudioDevice] {
	var propSize: UInt32 = 0

	var address = AudioObjectPropertyAddress(
		mSelector: AudioObjectPropertySelector(kAudioHardwarePropertyDevices),
		mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
		mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))

	var result = AudioObjectGetPropertyDataSize(
		AudioObjectID(kAudioObjectSystemObject),
		&address,
		UInt32(MemoryLayout<AudioObjectPropertyAddress>.size),
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

func setDevice(to query: String) {
	let devices = findDevices()
	let deviceType = shouldChangeInput ? "input" : "output"

	guard
		let device = devices.first(where: {
			$0.name?.localizedCaseInsensitiveContains(query) == true
				 && (shouldChangeInput ? !$0.hasOutput : $0.hasOutput)
		})
	else {
		print("Could not find \(deviceType) device \(query)")
		exit(1)
	}

	let deviceName = device.name ?? query
	var deviceId = device.audioDeviceID
	let deviceIdSize = UInt32(MemoryLayout.size(ofValue: deviceId))
	let selector = shouldChangeInput
		? kAudioHardwarePropertyDefaultInputDevice
		: kAudioHardwarePropertyDefaultOutputDevice

	var deviceIdPropertyAddress = AudioObjectPropertyAddress(
		mSelector: AudioObjectPropertySelector(selector),
		mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
		mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))

	let result = AudioObjectSetPropertyData(
		AudioObjectID(kAudioObjectSystemObject),
		&deviceIdPropertyAddress,
		0,
		nil,
		deviceIdSize,
		&deviceId)

	if (result != 0) {
		print("Could not set \(deviceType) to \(deviceName)")
		exit(0)
	}

	print("Set \(deviceType) to \(deviceName)")
}

setDevice(to: query)
