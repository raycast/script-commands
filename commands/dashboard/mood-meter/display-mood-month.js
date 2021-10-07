#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Display Mood Month
// @raycast.mode inline
// @raycast.refreshTime 5s
// @raycast.packageName Dashboard
//
// Optional parameters:
// @raycast.icon ☕️

// Documentation:
// @raycast.description Displays month mood table 
// @raycast.author Federico Miraglia
// @raycast.authorURL https://github.com/Mitra98t


const { exec } = require('child_process')
const fs = require("fs")
const homedir = require('os').homedir();
const filePath = `${homedir}/.moodTable.json`

if (!fs.existsSync(filePath)) {
    exec(`echo '{}' > ${filePath}`)
}
let json = fs.readFileSync(filePath)
let parsedMoods = JSON.parse(json)
let now = new Date()
let bars = { full: "▓", empty: "░" }

if (parsedMoods[now.getFullYear()] == null) {
    parsedMoods[now.getFullYear()] = [[], [], [], [], [], [], [], [], [], [], [], []]
    fs.writeFileSync(filePath, JSON.stringify(parsedMoods))
    console.log("loading...")
}

let resArr = [];
for (let i = 0; i < daysInMonth(now.getMonth(), now.getFullYear()); i++) {
    let toAdd = 0
    for (const day of parsedMoods[now.getFullYear()][now.getMonth()]) {
        if (day.date - 1 == i) {
            toAdd = day.mood
        }
    }
    resArr.push(toAdd)
}


let res = "";
for (const day of resArr) {
    let val = ""
    switch (day) {
        case 1:
            val = `\x1b[38;5;88m${bars.full}\x1b[0m`
            break;
        case 2:
            val = `\x1b[38;5;166m${bars.full}\x1b[0m`
            break;
        case 3:
            val = `\x1b[38;5;214m${bars.full}\x1b[0m`
            break;
        case 4:
            val = `\x1b[38;5;70m${bars.full}\x1b[0m`
            break;
        case 5:
            val = `\x1b[38;5;46m${bars.full}\x1b[0m`
            break;

        default:
            val = `${bars.empty}`
            break;
    }
    res += val
}


console.log(res)

function daysInMonth(month, year) {
    return month <= 6
        ? (month % 2 == 0 ? 31 : month == 1 ? isLeapYear(year) ? 29 : 28 : 30)
        : (month % 2 == 0 ? 30 : 31)
}

function isLeapYear(year) {
    return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
}
