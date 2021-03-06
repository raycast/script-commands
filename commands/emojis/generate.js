// Thanks to https://github.com/ikatyang/emoji-cheat-sheet

const fs = require("fs");
const https = require("https");
const path = require("path");

function fetchJSON(url, options) {
  return new Promise((resolve, reject) => {
    https
      .get(url, options || {}, (res) => {
        let data = "";
        res.on("data", (chunk) => {
          data += chunk;
        });
        res.on("end", () => {
          resolve(JSON.parse(data));
          console.log();
        });
      })
      .on("error", reject);
  });
}

function getEmojimap(cheatSheet, groupMap) {
  const getLast = (array) => array[array.length - 1];
  return Object.entries(cheatSheet)
    .filter(([_, url]) => url.includes("/unicode/"))
    .map(([id, url]) => {
      const codePointTexts = getLast(url.split("/"))
        .split(".png")[0]
        .split("-");
      const emoji = codePointTexts
        .map((codePointText) =>
          String.fromCodePoint(Number.parseInt(codePointText, 16))
        )
        .join("");
      const group = groupMap[codePointTexts[0]];
      return [id, emoji, group];
    });
}

function generate([title, emoji, group]) {
  const template = fs.readFileSync("./emoji.template.js", {
    encoding: "utf8",
    flag: "r",
  });
  const contents = template
    .replace("%title%", title)
    .replace(/%emoji%/g, emoji);
  const folder = path.join(__dirname, group);
  if (!fs.existsSync(folder)) {
    fs.mkdirSync(folder);
  }
  fs.writeFileSync(`${group}/emoji-${title}.js`, contents);
}

(async function () {
  const emojis = await fetchJSON(
    "https://unpkg.com/emoji.json@13.1.0/emoji.json"
  );
  const groupMap = {};
  for (const emoji of emojis) {
    const group = emoji["group"]
      .toLowerCase()
      .replace("&", "and")
      .replace(/ /g, "-");
    const codes = emoji["codes"].split(" ").map((code) => code.toLowerCase());
    codes.forEach((code) => (groupMap[code] = group));
  }
  const cheatSheet = await fetchJSON("https://api.github.com/emojis", {
    headers: { "User-Agent": "Raycast" },
  });
  const emojiMap = getEmojimap(cheatSheet, groupMap);
  emojiMap.map(generate);
  console.log(`${emojiMap.length} emoji scripts generated`);
})().catch(console.error);
