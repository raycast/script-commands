#!/usr/bin/env zx

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Lights
// @raycast.mode inline
// @raycast.packageName Philips Hue

// Optional parameters:
// @raycast.icon 💡
// @raycast.refreshTime 2m

// Documentation:
// @raycast.author Jono Hewitt
// @raycast.authorURL https://github.com/jonohewitt
// @raycast.description Show inline summary of any Hue compatible lights. Choose to show on/off, brightness percentage, color temperature or hue, saturation, brightness values. Recommended to have already assigned names to lights in the Hue app.

// This script requires:

// • A global install of zx. To install, run 'npm i -g zx' or 'yarn global add zx'.
//   More info: https://github.com/google/zx
// • Your Hue Bridge local IP address, e.g 192.168.1.2
// • An authorized username, e.g 1028d66426293e821ecfd9ef1a0731df
// • Names to be assigned to the bulbs. You can do this in the Hue app.

// Follow the steps here for the bridge IP and how to create a username:
// https://developers.meethue.com/develop/get-started-2/

// Remember to remove .template from the filename after customizing.

// Config:
const hueBridgeIP = '<enter bridge ip here>' // e.g 192.168.1.2
const userID = '<enter username here>' // e.g 1028d66426293e821ecfd9ef1a0731df

// 0 for On/Off
// 1 for brightness percentage,
// 2 for Hue, Saturation, Brightness if supported by full color bulbs,
// or color temperature in K and brightness percentage in temperature only lights, e.g 'White Ambiance'
const outputType = 1

// Optional:
// Specify which lights you want to include, in order, by their name (case sensitive).
// These names must have already been assigned to the lights via the Hue app.
// Use an empty array for all lights.
const chosenLights = [] // E.g ['Main', 'Desk']

// Optional:
// If you want to use a different bulb name to the name in your Hue settings, you can assign that here.
// The object key is the Hue name and the value is your arbitrary custom name.
const customNames = {} // E.g { Main: 'Ceiling', Desk: 'Lamp' }

// Code:

// Necessary to prevent fetch logging to the console automatically
$.verbose = false

// Collect data on all lights connected to the bridge
const lightsData = await fetch(`http://${hueBridgeIP}/api/${userID}/lights`, {
  method: 'get',
}).then(res => res.json())

Object.keys(customNames)
  .concat(chosenLights)
  .forEach(lightName => {
    if (!Object.entries(lightsData).find(bulb => bulb[1].name === lightName)) {
      console.error(
        `"${lightName}" isn't a bulb name yet! Check chosenLights & customNames`
      )
      process.exit(1)
    }
  })

const reducer = (output, bulb) => {
  output += `${customNames[bulb.name] || bulb.name}: `
  if (bulb.state.reachable && bulb.state.on) {
    // Conditions are stacked with logical OR operators so that no bulb is asked for values it doesn't support
    if (outputType === 0 || bulb.type === 'On/off light') {
      output += 'On, '
    } else if (outputType === 1 || bulb.type === 'Dimmable light') {
      // Convert brightness from (0-254) to (0-100%)
      output += `${Math.round((bulb.state.bri / 254) * 100)}%, `
    } else if (outputType === 2) {
      if (bulb.type === 'Color temperature light') {
        // Convert color temperature from mired units to kelvin units
        output += `${Math.round(1000000 / bulb.state.ct)} K, ${Math.round(
          (bulb.state.bri / 254) * 100
        )}%, `
      } else if (
        bulb.type === 'Color light' ||
        bulb.type === 'Extended color light'
      ) {
        // Convert hue from (0-65535) to (0-360°)
        output += `${Math.round((bulb.state.hue / 65535) * 360)}°, ${Math.round(
          (bulb.state.sat / 254) * 100
        )}%, ${Math.round((bulb.state.bri / 254) * 100)}% — `
      }
    }
  } else if (bulb.state.reachable) output += 'Off, '
  // Usually this means the light has been turned off manually at a switch
  else output += 'Unreachable, '

  return output
}

const inlineOutput = Object.entries(lightsData)
  .map(entry => entry[1])
  .filter(light => !chosenLights.length || chosenLights.includes(light.name))
  .sort((a, b) => {
    if (chosenLights.length) {
      return chosenLights.indexOf(a.name) - chosenLights.indexOf(b.name)
    }
  })
  .reduce(reducer, '')
  .slice(0, -2)

console.log(inlineOutput || 'No lights found, check your configuration!')
