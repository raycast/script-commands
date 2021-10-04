#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Mood Add
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


const fs = require("fs")

let json = fs.readFileSync("./moodTable.json")
let parsedMoods = JSON.parse(json)
let now = new Date()
var moodVal = Number(process.argv.slice(2)[0])
var dayNum = Number(process.argv.slice(2)[1])

if (parsedMoods[now.getFullYear()] == null) {
    parsedMoods[now.getFullYear()] = [[], [], [], [], [], [], [], [], [], [], [], []]
    fs.writeFileSync("./moodTable.json", JSON.stringify(parsedMoods))
}

if (moodVal > 0 && moodVal <= 5) {
    let dayVal = dayNum && dayNum > 0 && dayNum <= 31 ? dayNum : now.getDate()
    let index = parsedMoods[now.getFullYear()][now.getMonth()].findIndex(d => d.date == dayVal)
    if (index != -1)
        parsedMoods[now.getFullYear()][now.getMonth()][index] = { date: dayVal, mood: moodVal }
    else
        parsedMoods[now.getFullYear()][now.getMonth()].push({ date: dayVal, mood: moodVal })
    fs.writeFileSync("./moodTable.json", JSON.stringify(parsedMoods))
    console.log("Added mood for today ☕️")
}
else console.log("Mood must be between 1 and 5")