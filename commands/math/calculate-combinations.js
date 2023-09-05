#!/usr/bin/env node
// Dependency: This script requires Nodejs.
// Install Node: https://nodejs.org/en/download/

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title nCr: Calculate Combinations
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 𝐂
// @raycast.argument1 { "type": "text", "placeholder": "n" }
// @raycast.argument2 { "type": "text", "placeholder": "r" }
// Documentation:
// @raycast.description nCr: Calculate combinations
// @raycast.author cSharp
// @raycast.authorURL https://github.com/noidwasavailable

const child_process = require('child_process');

// Function to copy data to clipboard
const pbcopy = (data) => {
  return new Promise(function (resolve, reject) {
    const child = child_process.spawn('pbcopy');

    child.on('error', function (err) {
      reject(err);
    });

    child.on('close', function (err) {
      resolve(data);
    });

    child.stdin.write(data);
    child.stdin.end();
  });
};

// get args
const n = Number(process.argv.slice(2)[0]);
const r = Number(process.argv.slice(2)[1]);

// performance optimizations
const memoize = (fn) => {
  const cache = {};
  return (...args) => {
    const n = args[0];
    if (n in cache) {
      return cache[n];
    }
    const result = fn(n);
    cache[n] = result;
    return result;
  };
};

// factorial function
const factorial = memoize((n) => {
  if (n === 0 || n === 1) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
});

// calculate nCr
const nCr = factorial(n) / (factorial(r) * factorial(n - r));
console.log(`${n} choose ${r} = ${nCr}`);
pbcopy(`${nCr}`);

return nCr;
