#!/usr/bin/env node

// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Time Calculator
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 🕒
// @raycast.argument1 { "type": "text", "placeholder": "Starting Date (Default: now)", "optional":true }
// @raycast.argument2 { "type": "text", "placeholder": "Time to Add/Subtract (eg: -44, 44, +44)" }
// @raycast.argument3 { "type": "text", "placeholder": "s, m, h, d, w, y (Default: h)", "optional":true}
// @raycast.description Add or Subtract specified amount of time from given date.
// @raycast.packageName Developer Utilities

// Documentation:
// @raycast.author Federico Miraglia
// @raycast.authorURL https://github.com/Mitra98t

const dateReg = new RegExp(/^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/)

var value = process.argv.slice(2)[1]
var unit = process.argv.slice(2)[2] == "" ? "h" : process.argv.slice(2)[2]
var operator = ""

if (unit != "s" && unit != "m" && unit != "h" && unit != "d" && unit != "w" && unit != "y") {
    console.log("Use s, m, h, d, w, y as units of measure")
    return null
}

if (!/^[-\+]?\d+$/.test(value)) {
    console.log("Only numbers eg: -44, 44, +44")
    return null
}
else{
    operator = value.charAt(0)
    if(/^[-\+]$/.test(operator))
        value = value.substring(1)
}

function conversion(n, unit) {
    switch (unit) {
        case "s":
            return n * 1000
            break;
        case "m":
            return n * 60000
            break;
        case "h":
            return n * 3600000
            break;
        case "d":
            return (n * 24) * 3600000
            break;
        case "w":
            return ((n * 7) * 24) * 3600000
            break;
        case "y":
            return n * 31556952000
            break;

        default:
            return { err: true, message: "Wrong time format" }
            break;
    }
}


var nowDate = process.argv.slice(2)[0]
if (nowDate != "") {
    if(!dateReg.test(nowDate)){
        console.log("Use format yyyy-mm-dd or yyyy-m-d")
        return null
    }
    else{
        nowDate = new Date(nowDate)
    }
}
else{
    nowDate = new Date()
}

var nowMS = nowDate.getTime()

var resMS = operator !== "-" ? nowMS + conversion(value, unit) : nowMS - conversion(value, unit)

var resDate = new Date(resMS)

var resString = `${resDate.getFullYear()}-${resDate.getMonth() + 1}-${resDate.getDate()} | ${resDate.getHours()}:${resDate.getMinutes()}:${resDate.getSeconds()} | Unix ${resMS}`

console.log(resString)