# Raycast Script Commands

[Raycast](https://raycast.com) lets you control your tools with a few keystrokes
and Script Commands makes it possible to execute scripts from anywhere on your desktop.
They are a great way to speed up every-day tasks such as converting data, opening bookmarks
or triggering dev workflows.

This repository contains sample commands and documentation to write your own ones.

### Content

- [Bookmarks](#bookmarks)
- [Browsing](#browsing)
- [Communication](#communication)
- [Conversions](#conversions)
- [Dashboard](#dashboard)
- [Developer Utils](#developer-utils)
- [Media](#media)
- [Navigation](#navigation)
- [System](#system)

## Bookmarks

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📜 | [Open Script Commands Repository](bookmarks/open-script-commands-repository.sh) | N/A | Raycast |

## Browsing

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🔗 | [Shorten URL From Clipboard](browsing/shorten-url.sh) | Shorten the URL in your Clipboard with Tiny URL. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |

#### Safari

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🧭 | [Copy Current Page URL](browsing/safari-current-page-url.sh) | This script copies URL of currently opened page in Safari into clipboard. | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 🧭 | [Copy Current Window URLs](browsing/safari-current-window-urls.applescript) | This script copies to clipboard all URLs from frontmost Safari window. | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |

## Communication

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🔐 | [2FA from iMessages](communication/imessage-2fa.sh) | Get most recent two-factor authentication code from iMessages. | Caleb Stauffer and Thiago Holanda |

## Conversions

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
|  | [Column to Comma](conversions/column-to-comma.sh) | N/A | Raycast |
| ⏱ | [Convert Epoch to Human-Readable Date](conversions/epoch-to-human-date.sh) | Convert epoch to human-readable date. | [Siyuan Zhang](https://github.com/kastnerorz) |
| 🎨 | [Hex to RGB](conversions/hex-to-rgb.sh) | Convert HEX color values in your Clipboard to RGB values. | [Caleb Stauffer](https://github.com/crstauf) |
| 🎨 | [Hex to RGBA](conversions/hex-to-rgba.sh) | Convert HEX color values in your Clipboard to RGBA values. | [Caleb Stauffer](https://github.com/crstauf) |

## Dashboard

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🌦️ | [Current Weather](dashboard/current-weather.sh) | Get current weather report from wttr.in. | [Caleb Stauffer](https://github.com/crstauf) |
| 📈 | [System Activity](dashboard/system-activity.sh) | N/A | Raycast |

#### Internet

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/dashboard/images/speedtest-logo.png?raw=true" width="20" height="20"> | [Speedtest](dashboard/speedtest.sh) | Test download and upload connection speed | [Caleb Stauffer](https://github.com/crstauf) |

## Developer Utils

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📝 | [Copy Lorem Ipsum](developer-utils/lorem-ipsum.sh) | N/A | Raycast |
| 💻 | [Decode Base64](developer-utils/decode-base64.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/developer-utils/images/jwt-logo.png?raw=true" width="20" height="20"> | [Decode JWT](developer-utils/decode-jwt.sh) | N/A | Raycast |
| 💻 | [Encode Base64](developer-utils/encode-base64.sh) | N/A | Raycast |
| 💻 | [Generate UUID](developer-utils/generate-uuid.sh) | N/A | Raycast |
| 💻 | [Prettify JSON](developer-utils/prettify-json.sh) | N/A | Raycast |
| 📱 | [Record Simulator](developer-utils/record-simulator.sh) | Records simulator to Downloads folder with a filename from the clipboard | [Maxim Krouk](https://github.com/maximkrouk) |

#### Internet

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🌐 | [Ping Address in Clipboard](developer-utils/ping-from-clipboard.sh) | Ping an IP address or URL in clipboard. | [Caleb Stauffer](https://github.com/crstauf) |
| 🌐 | [Ping Monitor](developer-utils/ping-monitor.template.sh) | Ping an IP address or URL on an interval. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/developer-utils/images/ia-logo.jpg?raw=true" width="20" height="20"> | [Save Clipboard URL to Wayback Machine](developer-utils/wayback-machine-save.sh) | Save clipboard URL to Wayback Machine | [Caleb Stauffer](https://github.com/crstauf) |
| 🌐 | [Whois of Clipboard URL](developer-utils/whois.sh) | Whois of clipboard URL. | [Caleb Stauffer](https://github.com/crstauf) |

#### Xcode

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🧹 | [Clear Derived Data](developer-utils/clear-derived-data.sh) | N/A | Raycast |

## Media

## Navigation

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📂 | [Open Applications](navigation/open-applications.sh) | N/A | Raycast |
| 🖥 | [Open Clipboard URL on Desktop](navigation/open-desktop-url-from-clipboard.swift) | N/A | Raycast |
| 📟 | [Open Current Finder Directory in Terminal](navigation/open-terminal-from-finder.applescript) | Open curren Finder directory in terminal | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 📟 | [Open Current Terminal Directory in Finder](navigation/open-finder-from-terminal.applescript) | Open curren terminal directory in Finder | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 📂 | [Open Desktop](navigation/open-desktop.sh) | N/A | Raycast |
| 📂 | [Open Documents](navigation/open-documents.sh) | N/A | Raycast |
| 📂 | [Open Downloads](navigation/open-downloads.sh) | N/A | Raycast |
| 📂 | [Open Home](navigation/open-home.sh) | N/A | Raycast |
| 📂 | [Open Library](navigation/open-library.sh) | N/A | Raycast |
| 🌐 | [Open URL From Clipboard](navigation/open-url-from-clipboard.sh) | N/A | Raycast |
| 📂 | [Open Utilities](navigation/open-utilities.sh) | N/A | Raycast |

## System

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📅 | [Copy Availability](system/copy-availability.swift) | N/A | Raycast |
| 💁 | [Copy Last Download](system/copy-last-download.swift) | N/A | Raycast |
| 📸 | [Copy Last Screenshot](system/copy-last-screenshot.swift) | N/A | Raycast |
| 📀 | [Eject All Disks](system/eject-all-disks.applescript) | N/A | Raycast |
| 🗑 | [Empty Trash](system/empty-trash.applescript) | N/A | Raycast |
| 💁‍♂️ | [Open Last Download](system/open-last-download.swift) | N/A | Raycast |
| 💥 | [Quit All Applications](system/quit-all-apps.swift) | N/A | Raycast |
| 🖼️ | [Refresh Wallpaper](system/wallpaper-refresh.applescript) | Refresh the current display's wallpaper | [Caleb Stauffer](https://github.com/crstauf) |
| ♻️ | [Restart](system/restart.applescript) | N/A | Raycast |
| 🌀 | [Screen Saver](system/screensaver.applescript) | A script command to start your current screen saver. | [Valentin Chrétien](https://twitter.com/valentinchrt) |
| 🛌 | [Shut Down](system/shutdown.applescript) | N/A | Raycast |
| 😴 | [Sleep](system/sleep.applescript) | N/A | Raycast |
| 🖥 | [Toggle Desktop Icons](system/toggle-desktop-icons.applescript) | A script command to show and hide icons of Desktop folder | [Raycast](https://raycast.com) |
| 👓 | [Toggle Hidden Files](system/toggle-hidden-files.applescript) | Show and hide hidden files/folders which starts with "." (dot), i.e: .bash_rc, .ssh | [Thiago Holanda](https://twitter.com/tholanda) |
| 🌗 | [Toggle System Appearance](system/toggle-system-appearance.applescript) | Script Command to switch between the system appearance, light and dark mode. | [Thiago Holanda](https://twitter.com/tholanda) |

## Community

This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast.
If you have anything cool to show, please send us a pull request. If we screwed something up,
please report a bug. Join our
[Slack community](https://join.slack.com/t/raycastcommunity/shared_invite/zt-hhzj9i4m-D5~HwnTRsJKrcZmVDJ4mkg)
to brainstorm ideas with like-minded folks.