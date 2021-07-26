#!/usr/bin/env zx

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Rooms
// @raycast.mode inline
// @raycast.packageName Philips Hue

// Optional parameters:
// @raycast.icon 💡
// @raycast.refreshTime 2m

// Documentation:
// @raycast.author Jono Hewitt
// @raycast.authorURL https://github.com/jonohewitt
// @raycast.description Show inline summary about your rooms of Hue compatible lights. Choose to show the number of lights on out of the room total, or use more general terms such as "All on". Requires rooms to have already been set up in the Hue app.

// This script requires:

// • A global install of zx. To install, run 'npm i -g zx' or 'yarn global add zx'.
//   More info: https://github.com/google/zx
// • Your Hue Bridge local IP address, e.g 192.168.1.2
// • An authorized username, e.g 1028d66426293e821ecfd9ef1a0731df
// • Names to be assigned to the rooms. You can do this in the Hue app.

// Follow the steps here for the bridge IP and how to create a username:
// https://developers.meethue.com/develop/get-started-2/

// Remember to remove .template from the filename after customizing.

// Config:

const hueBridgeIP = '<enter bridge ip here>' // e.g 192.168.1.2
const userID = '<enter username here>' // e.g 1028d66426293e821ecfd9ef1a0731df
const specificOutput = true // true for e.g "2/2 lights on", false for "All on" / "Some on" / "All off"

// Optional:
// Specify which rooms you want to include, in order, by their name (case sensitive).
// These names must have already been assigned to the rooms via the Hue app.
// Use an empty array for all rooms.
const chosenRooms = [] // E.g ['Bedroom', 'Study']

// Optional:
// If you want to use a different room name to the name in your Hue settings, you can assign that here.
// The object key is the Hue name and the value is your arbitrary custom name.
const customNames = {} // E.g { Bedroom: 'My room', Study: 'Office' }

// Code:

// Necessary to prevent fetch logging to the console automatically
$.verbose = false

// The Hue API doesn't provide 'reachable' data for groups, so this is collected from each light instead
const lightsData = await fetch(`http://${hueBridgeIP}/api/${userID}/lights`, {
  method: 'get',
}).then(res => res.json())

const roomsData = await fetch(`http://${hueBridgeIP}/api/${userID}/groups`, {
  method: 'get',
}).then(res => res.json())

Object.keys(customNames)
  .concat(chosenRooms)
  .forEach(roomName => {
    if (!Object.entries(roomsData).find(room => room[1].name === roomName)) {
      console.error(
        `"${roomName}" isn't a room name yet! Check chosenRooms & customNames`
      )
      process.exit(1)
    }
  })

const reducer = (output, room) => {
  const totalLights = room.lights.length
  const onLights = room.lights.filter(
    id => lightsData[id].state.on && lightsData[id].state.reachable
  ).length

  if (totalLights > 0) {
    output += `${customNames[room.name] || room.name}: `
    if (specificOutput) output += `${onLights}/${totalLights} lights on, `
    else {
      if (onLights === totalLights) output += 'All on, '
      else if (onLights > 0) output += 'Some on, '
      else output += 'All off, '
    }
  }
  return output
}

const inlineOutput = Object.entries(roomsData)
  .map(entry => entry[1])
  .filter(room => !chosenRooms.length || chosenRooms.includes(room.name))
  .sort((a, b) => {
    if (chosenRooms.length) {
      return chosenRooms.indexOf(a.name) - chosenRooms.indexOf(b.name)
    }
  })
  .reduce(reducer, '')
  .slice(0, -2)
console.log(inlineOutput || 'No rooms found, check your configuration!')
