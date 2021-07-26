#!/usr/bin/env zx

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Set Room Lights
// @raycast.mode silent
// @raycast.packageName Philips Hue

// Optional parameters:
// @raycast.icon 💡
// @raycast.argument1 { "type": "text", "placeholder": "preset", "optional": true }
// @raycast.argument2 { "type": "text", "placeholder": "value (hsb or brightness)", "optional": true }
// @raycast.argument3 { "type": "text", "placeholder": "room", "optional": true }

// Documentation:
// @raycast.author Jono Hewitt
// @raycast.authorURL https://github.com/jonohewitt
// @raycast.description Set a specified or default room of color bulbs to a preset, hsb or brightness value. Leave preset and value arguments empty to toggle a room on or off.

// This script requires:

// • A global install of zx. To install, run 'npm i -g zx' or 'yarn global add zx'.
//   More info: https://github.com/google/zx
// • Your Hue Bridge local IP address, e.g 192.168.1.2
// • An authorized username, e.g 1028d66426293e821ecfd9ef1a0731df
// • A group/room ID, e.g 2

// Follow the steps here for the bridge IP and how to create a username:
// https://developers.meethue.com/develop/get-started-2/

// Then go to https://<bridge ip address>/api/<username>/groups to see the number ID associated with each room you've set up.
// Assign one of these numbers to the defaultRoom variable below, then add each other room in the first section of the script.

// The script uses comma separated HSB, a.k.a HSV, (Hue: 0-360, Saturation: 0-100, Brightness: 0-100) for inputting color values.
// If only one number is provided, it is assumed to be brightness (0-100)
// If neither a preset nor value are provided, the current 'on' state for the room is toggled

// Remember to remove .template from the filename after customizing.

const hueBridgeIP = '<enter bridge ip here>' // e.g 192.168.1.2
const userID = '<enter username here>' // e.g 1028d66426293e821ecfd9ef1a0731df
const defaultRoom = '<enter default room id here>' // e.g 2

// Necessary to prevent fetch logging to the console automatically
$.verbose = false

const [presetInput, valueInput, roomInput] = process.argv.slice(3)
let on, hue, sat, bri, roomID, data

// Fetch existing data for all rooms
const prevRoomData = await fetch(
  `http://${hueBridgeIP}/api/${userID}/groups/`,
  { method: 'get' }
).then(res => res.json())

if (roomInput) {
  // If the roomInput string matches a name assigned to one of the rooms on the Hue bridge,
  // the script will automatically use its ID instead of testing against the names in the switch statement
  const matchedRoom = Object.entries(prevRoomData).find(
    room => room[1].name.toLowerCase() === roomInput.toLowerCase()
  )
  if (matchedRoom) roomID = matchedRoom[0]
  else {
    // Assign room IDs to input strings here, some examples are included already
    // The defaultRoom id assigned in the top config will be used if a room argument isn't provided
    // The switch converts all inputs to lowercase, so you should only use lowercase for the case statements.
    // That way, the Raycast input will be case insensitive.
    switch (roomInput.toLowerCase()) {
      // Multiple inputs can be assigned to the same room by stacking case statements
      case 'dining room':
      case 'dining':
      case 'din':
        roomID = 2 // Change these numbers to match your API results
        break
      case 'study':
      case 'office':
        roomID = 3
        break
      // Add more presets with more case statements here
      default:
        console.error(`${roomInput} isn't configured yet!`)
        process.exit(1)
    }
  }
} else roomID = defaultRoom

if (!prevRoomData[roomID]) {
  console.error(`Room ID: ${roomID} wasn't found on your Hue bridge!`)
  process.exit(1)
}

// Assign your presets here, some examples are included already
if (presetInput) {
  switch (presetInput.toLowerCase()) {
    case 'on':
      on = true
      break
    case 'off':
      on = false
      break
    case 'sunset':
      on = true
      hue = 15
      sat = 100
      bri = 20
      break
    case 'bright':
      on = true
      hue = 45
      sat = 25
      bri = 100
      break
    // Add more presets with more case statements here
    default:
      console.error('Preset not found!')
      process.exit(1)
  }
  // If there isn't any presetInput or valueInput, this condition toggles the room on or off
  // Remove if you would rather receive a 'No data provided' error without any changes made
} else if (!valueInput) on = !prevRoomData[roomID].state.any_on

// If a color input is provided, this section tests and assigns the values from it
// This section doesn't require any further configuration
if (valueInput) {
  // Check for letters or hashtags in the input implying a HEX value
  const hexRegex = /[a-zA-Z]|#/
  if (hexRegex.test(valueInput)) {
    console.error("HEX values aren't supported!")
    process.exit(1)
  }
  // Validate the input format
  const formatRegex =
    /^\d+\.?\d*\W?$|^\d+\.?\d*\W?,\s?\d+\.?\d*\W?,\s?\d+\.?\d*\W?$/
  if (!formatRegex.test(valueInput)) {
    console.error("HSB or brightness input isn't formatted correctly!")
    process.exit(1)
  }

  // Split the comma separated HSB string into an array,
  // remove any non-numeric characters other than decimal points, e.g degree or percentage symbols
  const hsbArray = valueInput
    .split(',')
    .map(value => value.replace(/(?=\D)[^\.]/g, ''))

  // Test for out of bounds color values
  function checkValue(value, limit) {
    if (value > limit) {
      console.error('Bad value input!')
      process.exit(1)
    } else return value
  }

  // If the array only has one entry, assign it to brightness
  if (hsbArray.length === 1) {
    bri = checkValue(hsbArray[0], 100)
    on = true
    // Otherwise assign each entry as HSB values
  } else {
    hue = checkValue(hsbArray[0], 360)
    sat = checkValue(hsbArray[1], 100)
    bri = checkValue(hsbArray[2], 100)
    on = true
  }
}

// Convert the color model
if (hue) hue = Math.floor((hue * 65535) / 360)
if (sat) sat = Math.floor((sat * 254) / 100)
if (bri) bri = Math.floor((bri * 254) / 100)

// If there is color information, include it all in the data
if (hue !== undefined) data = { on: on, hue: hue, sat: sat, bri: bri }
// If there is only brightness info, update it without overwriting the existing color data
else if (bri !== undefined) data = { on: on, bri: bri }
// Otherwise only change the "on" state without overwriting the existing color data
else if (on !== undefined) data = { on: on }
else {
  console.error('No data provided!')
  process.exit(1)
}

await fetch(`http://${hueBridgeIP}/api/${userID}/groups/${roomID}/action`, {
  method: 'put',
  body: JSON.stringify(data),
  headers: { 'Content-Type': 'application/json' },
})
  .then(res => res.json())
  .then(data => {
    if (data.every(message => message.success)) {
      console.log(`${prevRoomData[roomID].name} lights updated!`)
    }
  })
