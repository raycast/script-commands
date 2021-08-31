#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Time Between Dates
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon 🕒
// @raycast.argument1 { "type": "text", "placeholder": "First Date (Default: now)", "optional":true}
// @raycast.argument2 { "type": "text", "placeholder": "Second Date" }
// @raycast.description Given two dates returns the time between them in multiple units of measure.
// @raycast.packageName Developer Utilities

// Documentation:
// @raycast.author Federico Miraglia
// @raycast.authorURL https://github.com/Mitra98t

const dateReg = new RegExp(/^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/)

var firstD = process.argv.slice(2)[0]
var secondD = process.argv.slice(2)[1]

if(firstD != ""){
    if(!dateReg.test(secondD)){
        console.log("Use format yyyy-mm-dd or yyyy-m-d")
        return null
    }
    else {
        firstD = new Date(firstD)
    }
}
else {
    firstD = new Date()
}

if(!dateReg.test(secondD)){
    console.log("Use format yyyy-mm-dd or yyyy-m-d")
    return null
}
else{
    secondD = new Date(secondD)
}

var firstD1am = new Date(`${firstD.getFullYear()}-${firstD.getMonth() + 1}-${firstD.getDate()}`)

var diffMS = Math.abs(secondD.getTime() - firstD.getTime())
var diffMS1Am = Math.abs(secondD.getTime() - firstD1am.getTime())

var diffDays = Math.round(diffMS1Am / (1000 * 3600 * 24))
var diffHours = Math.round(diffMS / (1000 * 3600))
var diffYears = (diffMS / 31556952000).toFixed(2)

console.log(`There are ${diffMS} milliseconds`);
console.log(`There are ${diffHours} hours`);
console.log(`There are ${diffDays} days today excluded`);
console.log(`There are ${diffYears} years`);
console.log(`Between the two given dates.`);