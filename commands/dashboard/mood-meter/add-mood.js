#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add Mood
// @raycast.mode silent
// @raycast.packageName Dashboard
//
// Optional parameters:
// @raycast.icon ☕️
// @raycast.argument1 { "type": "text", "placeholder": "mood rating 1-5",}
// @raycast.argument2 { "type": "text", "placeholder": "Day number", "optional":true }


// Documentation:
// @raycast.description Add mood value to current or specified date 
// @raycast.author Federico Miraglia
// @raycast.authorURL https://github.com/Mitra98t


const { exec } = require('child_process')
const fs = require("fs")
const homedir = require('os').homedir();
const filePath = `${homedir}/.moodTable.json`
let now = new Date()

if (!fs.existsSync(filePath)) {
    exec(`echo '{}' > ${filePath}`)
}


let json = fs.readFileSync(filePath)
let parsedMoods = JSON.parse(json)
var moodVal = Number(process.argv.slice(2)[0])
var dayNum = Number(process.argv.slice(2)[1])

if (parsedMoods[now.getFullYear()] == null) {
    parsedMoods[now.getFullYear()] = [[], [], [], [], [], [], [], [], [], [], [], []]
    fs.writeFileSync(filePath, JSON.stringify(parsedMoods))
}

if (moodVal > 0 && moodVal <= 5) {
    let dayVal = dayNum && dayNum > 0 && dayNum <= 31 ? dayNum : now.getDate()
    let index = parsedMoods[now.getFullYear()][now.getMonth()].findIndex(d => d.date == dayVal)
    if (index != -1)
        parsedMoods[now.getFullYear()][now.getMonth()][index] = { date: dayVal, mood: moodVal }
    else
        parsedMoods[now.getFullYear()][now.getMonth()].push({ date: dayVal, mood: moodVal })
    fs.writeFileSync(filePath, JSON.stringify(parsedMoods))
    console.log("Added mood for today ☕️")
}
else console.log("Mood must be between 1 and 5")
