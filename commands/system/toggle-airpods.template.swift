#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Toggle AirPods
// @raycast.mode silent
// @raycast.packageName Audio
//
// Optional parameters:
// @raycast.icon images/airpod.png
//
// Documentation:
// @raycast.description Toggle AirPods bluetooth device
// @raycast.author Nichlas W. Andersen
// @raycast.authorURL https://github.com/itsnwa

import IOBluetooth

func toggleAirPods() {
    guard let bluetoothDevice = IOBluetoothDevice(addressString: "Your AirPods MAC address") else {
        print("Device not found")
        exit(1)
    }

    if !bluetoothDevice.isPaired() {
        print("Device not paired")
        exit(1)
    }

    if bluetoothDevice.isConnected() {
        print("AirPods Disconnected")
        bluetoothDevice.closeConnection()
    } else {
        print("AirPods Connected")
        bluetoothDevice.openConnection()
    }
}

toggleAirPods()
