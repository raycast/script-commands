#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Display Mood Year
// @raycast.mode fullOutput
// @raycast.packageName Dashboard
//
// Optional parameters:
// @raycast.icon ☕️
// @raycast.argument1 { "type": "text", "placeholder": "Year", "optional": true}

// Documentation:
// @raycast.description Displays year mood table 
// @raycast.author Federico Miraglia
// @raycast.authorURL https://github.com/Mitra98t


const { exec } = require('child_process')
const fs = require("fs")
const homedir = require('os').homedir();
const filePath = `${homedir}/.moodTable.json`
const monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];

if (!fs.existsSync(filePath)) {
    exec(`echo '{}' > ${filePath}`)
}

let json = fs.readFileSync(filePath)
let parsedMoods = JSON.parse(json)
let now = new Date()
let yearVal = Number(process.argv.slice(2)[0])
let bars = { full: "▓", empty: "░" }

if (parsedMoods[now.getFullYear()] == null) {
    parsedMoods[now.getFullYear()] = [[], [], [], [], [], [], [], [], [], [], [], []]
    fs.writeFileSync(filePath, JSON.stringify(parsedMoods))
}

let nowYear = yearVal && yearVal > 0 ? yearVal : now.getFullYear()
if (parsedMoods[nowYear] == null) {
    console.log("Empty year!")
    return
}
let resArr = [];
// * Mese parte da 0 (ottimo per index)
for (const month in parsedMoods[nowYear]) {
    resArr.push([]);
    for (let i = 0; i < daysInMonth(month, nowYear); i++) {
        let toAdd = 0
        let dayIndex = parsedMoods[nowYear][month].findIndex(d => d.date == i + 1)
        if (dayIndex != -1)
            toAdd = parsedMoods[nowYear][month][dayIndex].mood
        resArr[month].push(toAdd)
    }
}

let res = "";
for (const month in resArr) {
    res += `${monthNames[month]}\n`
    for (const day of resArr[month]) {
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
    if (month != 11)
        res += `\n`
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