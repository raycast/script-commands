<!-- AUTO GENERATED FILE. DO NOT EDIT. -->
# Raycast Script Commands

[Raycast](https://raycast.com) lets you control your tools with a few keystrokes
and Script Commands makes it possible to execute scripts from anywhere on your desktop.
They are a great way to speed up every-day tasks such as converting data, opening bookmarks
or triggering dev workflows.

This repository contains sample commands and documentation to write your own ones.

### Categories

- [Apps](#apps)
  - [Amphetamine](#amphetamine)
- [Bookmarks](#bookmarks)
- [Browsing](#browsing)
- [Communication](#communication)
  - [Cloudup](#cloudup)
  - [Emojis](#emojis)
  - [Gmail](#gmail)
  - [Slack](#slack)
- [Conversions](#conversions)
- [Dashboard](#dashboard)
  - [Countdowns](#countdowns)
- [Developer Utils](#developer-utils)
  - [Aws](#aws)
  - [Brew](#brew)
  - [Github](#github)
  - [Gitlab](#gitlab)
  - [Google](#google)
  - [Ip](#ip)
  - [Sentry](#sentry)
- [Media](#media)
  - [Apple Music](#apple-music)
  - [Apple Tv](#apple-tv)
  - [Cmus](#cmus)
  - [Spotify](#spotify)
- [Navigation](#navigation)
- [System](#system)
- [Web Searches](#web-searches)
  - [Wordpress](#wordpress)

## Apps

#### Amphetamine

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/apps/amphetamine/images/amphetamine.png?raw=true" width="20" height="20"> | [End Session](apps/amphetamine/amphetamine-off.applescript) | Stop Current Amphetamine Session | [James Lyons](https://github.com/jamesjlyons) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/apps/amphetamine/images/amphetamine.png?raw=true" width="20" height="20"> | [Start Default Session](apps/amphetamine/amphetamine-on.applescript) | Start Default Amphetamine Session | [James Lyons](https://github.com/jamesjlyons) |

## Bookmarks

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📜 | [Open Script Commands Repository](bookmarks/open-script-commands-repository.sh) | Open the GitHub repository for Script Commands provided by the community. | Raycast |

## Browsing

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🧭 | [Copy Current Page URL](browsing/safari-current-page-url.sh) | This script copies URL of currently opened page in Safari into clipboard. | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 🧭 | [Copy Current Window URLs](browsing/safari-current-window-urls.applescript) | This script copies to clipboard all URLs from frontmost Safari window. | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 🖼️ | [Screenshot Website](browsing/website-screenshots.sh) | Takes screenshots of the entered URL using [`pageres`](https://github.com/sindresorhus/pageres) and saves it to the Desktop. | [Caleb Stauffer](https://github.com/crstauf) |
| 🔗 | [Shorten URL From Clipboard](browsing/shorten-url.sh) | Shorten the URL in your Clipboard with Tiny URL. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |

## Communication

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🔐 | [2FA from iMessages](communication/imessage-2fa.sh) | Get most recent two-factor authentication code from iMessages. | [Caleb Stauffer](https://github.com/crstauf) and [Thiago Holanda](https://twitter.com/tholanda) |
| 🔐 | [Generate Passphrase](communication/xkcdpass.sh) | Use [xkcdpass](https://github.com/redacted/XKCD-password-generator) to create a passphrase. | [Caleb Stauffer](https://github.com/crstauf) |

#### Cloudup

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/communication/cloudup/images/cloudup-logo.png?raw=true" width="20" height="20"> | [Paste](communication/cloudup/cloudup-paste.sh) | Upload clipboard contents to [Cloudup](https://cloudup.com/). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/communication/cloudup/images/cloudup-logo.png?raw=true" width="20" height="20"> | [Pick](communication/cloudup/cloudup-pick.sh) | Open file dialog and upload to [Cloudup](https://cloudup.com/). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/communication/cloudup/images/cloudup-logo.png?raw=true" width="20" height="20"> | [Upload](communication/cloudup/cloudup-upload.sh) | Upload path or URL in clipboard to [Cloudup](https://cloudup.com/). | [Caleb Stauffer](https://github.com/crstauf) |

#### Emojis

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📙 | [Search Emojis](communication/emojis/emojis-search.sh) | Search for emojis related to input. | [Caleb Stauffer](https://github.com/crstauf) |
| 📙 | [Search and Copy First Related Emoji](communication/emojis/emoji-copy.sh) | Copy first emoji related to input. | [Caleb Stauffer](https://github.com/crstauf) |

#### Gmail

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/communication/gmail/images/google-gmail-logo.png?raw=true" width="20" height="20"> | [Gmail](communication/gmail/google-gmail.sh) | Open gmail.com in the default browser | [Michael Aigner](https://github.com/tonka3000) |

#### Slack

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
|  | [Clear Slack DND](communication/slack/clear-slack-DND-status.sh) | Clear DND Status in Slack | [Sam Ching](https://github.com/samching) |
| 🧼 | [Clear Status](communication/slack/clear-slack-status.template.sh) | Clear your status in Slack. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |
|  | [Set DND Status](communication/slack/set-slack-DND-status.sh) | Set your DND status in Slack | [Sam Ching](https://github.com/samching) |
| ☕️ | [Set Status to Coffee](communication/slack/set-slack-status.template.sh) | Set your status in Slack. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |

## Conversions

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
|  | [Column to Comma](conversions/column-to-comma.sh) | N/A | Raycast |
| ⏱ | [Convert Epoch to Human-Readable Date](conversions/epoch-to-human-date.sh) | Convert epoch to human-readable date. | [Siyuan Zhang](https://github.com/kastnerorz) |
| ⏱ | [Convert Human-Readable Date To Epoch](conversions/human-date-to-epoch.sh) | Convert human-readable date to timestamp epoch. | [Siyuan Zhang](https://github.com/kastnerorz) |
| 🎨 | [Hex to RGB](conversions/hex-to-rgb.sh) | Convert hexadecimal color value to RGB value. | [Caleb Stauffer](https://github.com/crstauf) |
| 🎨 | [Hex to RGBA](conversions/hex-to-rgba.sh) | Convert hexadecimal color value to RGBA value. | [Caleb Stauffer](https://github.com/crstauf) |

## Dashboard

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/dashboard/images/bitcoin-logo.png?raw=true" width="20" height="20"> | [Bitcoin Price](dashboard/bitcoin-price-usd.sh) | Get current Bitcoin price from Coindesk. | [Tanguy Le Stradic](https://github.com/tanguyls) |
| 🌦️ | [Current Weather](dashboard/current-weather.sh) | Get current weather report from [wttr.in](https://wttr.in/). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/dashboard/images/speedtest-logo.png?raw=true" width="20" height="20"> | [Speedtest](dashboard/speedtest.sh) | Test download and upload connection speed using [Speedtest](https://www.speedtest.net/apps/cli). | [Caleb Stauffer](https://github.com/crstauf) |
| 📈 | [System Activity](dashboard/system-activity.sh) | N/A | Raycast |
| 🕐 | [World Time](dashboard/world-time.sh) | Show the time from elsewhere in the world | [Jesse Claven](https://github.com/jesse-c) |
| ⏱ | [Year Progress](dashboard/year-progress.sh) | See the year progress on your desktop. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |

#### Countdowns

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🎅🏻 | [Countdown to Christmas](dashboard/countdowns/countdown-to-christmas.sh) | See how many days until Christmas. | [Valentin Chrétien](https://github.com/valentinchrt) |
| ⏱ | [Countdown to Date](dashboard/countdowns/countdown-to-date.template.sh) | See how many days/hours until a specific date. | [Valentin Chrétien](https://github.com/valentinchrt) |
| ⏱ | [Create Countdown](dashboard/countdowns/create-countdown.template.sh) | Create countdowns via Raycast. | [Valentin Chrétien](https://github.com/valentinchrt) |

## Developer Utils

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🔑 | [Add SSH Keys (with Terminal)](developer-utils/add-ssh-keys.template.applescript) | Add one or multiple SSH keys to your SSH agent (with Terminal). | [Caleb Stauffer](https://github.com/crstauf) |
| 🧹 | [Clear Derived Data](developer-utils/clear-derived-data.sh) | Clear the derived data of Xcode. | Raycast |
| 📝 | [Copy Lorem Ipsum](developer-utils/lorem-ipsum.sh) | Copy one paragraph of Lorem Ipsum to clipboard. | Raycast |
| 💻 | [Decode Base64](developer-utils/decode-base64.sh) | Decodes clipboard content to Base64 and copies it again. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/images/jwt-logo.png?raw=true" width="20" height="20"> | [Decode JWT](developer-utils/decode-jwt.sh) | Decodes JSON web token from the clipboard. | Raycast |
| 💻 | [Decode URL](developer-utils/decode-url.sh) | Decodes clipboard content url and copies it again. | Raycast |
| 💻 | [Encode Base64](developer-utils/encode-base64.sh) | Encodes clipboard content to Base64 and copies it again. | Raycast |
| 💻 | [Encode URL](developer-utils/encode-url.sh) | Encodes clipboard content url and copies it again. | Raycast |
| 💻 | [Escape String for Shell](developer-utils/escape-shell-chars.sh) | Escapes shell character string and copies it again. | Raycast |
| 🔐 | [Generate Password](developer-utils/generate-password.sh) | Generates a random password and copies it to the clipboard. | [Sven Hofmann](https://github.com/hofmannsven) |
| 💻 | [Generate UUID](developer-utils/generate-uuid.sh) | Generates a UUID and copies it to the clipboard. | Raycast |
| 🩺 | [Is It Up?](developer-utils/is-it-up.sh) | Check if a website is up | [Jesse Claven](https://github.com/jesse-c) |
| 🌐 | [Ping](developer-utils/ping.sh) | Ping an IP address or URL. | [Caleb Stauffer](https://github.com/crstauf) |
| 🌐 | [Ping Monitor](developer-utils/ping-monitor.template.sh) | Ping an IP address or URL on an interval. | [Caleb Stauffer](https://github.com/crstauf) |
| 💻 | [Prettify JSON](developer-utils/prettify-json.sh) | Pretty prints the JSON currently in the clipboard. | Raycast |
| 📱 | [Record Simulator](developer-utils/record-simulator.sh) | Records simulator to Downloads folder | [Maxim Krouk](https://github.com/maximkrouk) |
| 🛠 | [Run Command On Front Finder Window](developer-utils/run-command-in-finder.sh) | Runs the specified command in the path of the frontmost Finder window. | [Wesley Martin](https://github.com/itsmewes) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/images/pa11y-logo.png?raw=true" width="20" height="20"> | [Run Pa11y](developer-utils/pa11y.sh) | Run [Pa11y](https://github.com/pa11y/pa11y) web accessibility tool on specified path or URL. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/images/ia-logo.jpg?raw=true" width="20" height="20"> | [Save URL to Wayback Machine](developer-utils/wayback-machine-save.sh) | Save URL to [Wayback Machine](https://web.archive.org/). | [Caleb Stauffer](https://github.com/crstauf) |
| 🔎 | [Search Script Command](developer-utils/search-script-command.swift) | Search for Script Commands available in the Raycast repository | [Thiago Holanda](https://twitter.com/tholanda) |
| 🌐 | [Whois](developer-utils/whois.sh) | Whois of URL. | [Caleb Stauffer](https://github.com/crstauf) |

#### Aws

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🤖 | [Find AWS Region by IP](developer-utils/aws/whatismyregion.sh) | Copies the AWS IPv4 to the clipboard. | [Oğuzhan Yılmaz](https://github.com/c1982) |

#### Brew

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🍺 | [Doctor](developer-utils/brew/brew-doctor.sh) | Run Brew Doctor | [Thiago Holanda](https://twitter.com/tholanda) |
| 🍺 | [Outdated List](developer-utils/brew/brew-outdated.sh) | Show list of outdated formulae | [Thiago Holanda](https://twitter.com/tholanda) |
| 🍺 | [Services List](developer-utils/brew/brew-services-list.sh) | Show Brew Services List | [Thiago Holanda](https://twitter.com/tholanda) |
| 🍺 | [Start Service](developer-utils/brew/brew-services-start.sh) | Start Service in Brew | [Thiago Holanda](https://twitter.com/tholanda) |
| 🍺 | [Stop Service](developer-utils/brew/brew-services-stop.sh) | Stop Service in Brew | [Thiago Holanda](https://twitter.com/tholanda) |
| 🍺 | [Upgrade](developer-utils/brew/brew-upgrade.sh) | Run Brew Upgrade | [Thiago Holanda](https://twitter.com/tholanda) |

#### Github

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/github/images/github-logo-iconDark.png?raw=true" width="20" height="20"> | [Create GitHub Gist from Clipboard](developer-utils/github/create-github-gist.template.sh) | Create a GitHub Gist from clipboard contents and copy Gist URL. | [Caleb Stauffer](https://github.com/crstauf) |
| ⭐️ | [Repository Statistics](developer-utils/github/github-repository-stars.template.rb) | Show statistics of your GitHub repository. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/github/images/github-logo.png?raw=true" width="20" height="20"> | [Unread Notifications](developer-utils/github/github-unread-notifications.template.sh) | Display (detailed) number of unread GitHub notifications. | [Caleb Stauffer](https://github.com/crstauf) |

#### Gitlab

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/gitlab/images/gitlab.png?raw=true" width="20" height="20"> | [Issues](developer-utils/gitlab/gitlab-issues.template.py) | Show issues from GitLab | [Michael Aigner](https://github.com/tonka3000) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/gitlab/images/gitlab.png?raw=true" width="20" height="20"> | [Merge Requests](developer-utils/gitlab/gitlab-mergerequests.template.py) | Show merge requests from GitLab | [Michael Aigner](https://github.com/tonka3000) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/gitlab/images/gitlab.png?raw=true" width="20" height="20"> | [To-Dos](developer-utils/gitlab/gitlab-todos.template.py) | Show todos from GitLab | [Michael Aigner](https://github.com/tonka3000) |

#### Google

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/google/images/google-lighthouse-logo.png?raw=true" width="20" height="20"> | [Lighthouse](developer-utils/google/google-lighthouse.sh) | Open a [Lighthouse](https://developers.google.com/web/tools/lighthouse/) report of URL. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/google/images/google-psi-logo.png?raw=true" width="20" height="20"> | [PageSpeed Insights - Desktop](developer-utils/google/google-psi-desktop.sh) | Run a [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) analysis on desktop of URL. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/google/images/google-psi-logo.png?raw=true" width="20" height="20"> | [PageSpeed Insights - Mobile](developer-utils/google/google-psi-mobile.sh) | Run a [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) analysis on mobile of URL. | [Caleb Stauffer](https://github.com/crstauf) |

#### Ip

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 🌐 | [External IPv4](developer-utils/ip/get-external-ip-v4.sh) | Copies the external IPv4 to the clipboard. | Raycast |
| 🌐 | [External IPv6](developer-utils/ip/get-external-ip-v6.sh) | Copies the external IPv6 to the clipboard. | Raycast |
| 🌐 | [Local IPv4](developer-utils/ip/get-local-ip-v4.sh) | Copies the local IPv4 to the clipboard. | Raycast |
| 🌐 | [Local IPv6](developer-utils/ip/get-local-ip-v6.sh) | Copies the local IPv6 to the clipboard. | Raycast |
| 🌐 | [URL IPv4](developer-utils/ip/get-url-ip-v4.sh) | Get IPv4 address of URL. | [Caleb Stauffer](https://github.com/crstauf) |
| 🌐 | [URL IPv6](developer-utils/ip/get-url-ip-v6.sh) | Get IPv6 address of URL. | [Caleb Stauffer](https://github.com/crstauf) |

#### Sentry

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/developer-utils/sentry/images/sentry.png?raw=true" width="20" height="20"> | [Unresolved Issues](developer-utils/sentry/sentry-unresolved-issues.template.py) | Show unresolved issues of the last 24 hours from Sentry. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |

## Media

#### Apple Music

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Next Track](media/apple-music/apple-music-next.applescript) | Next track in Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Pause](media/apple-music/apple-music-pause.applescript) | Pause Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Play](media/apple-music/apple-music-play.applescript) | Play Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Previous Track](media/apple-music/apple-music-previous.applescript) | Previous track in Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Set Volume](media/apple-music/apple-music-set-volume.applescript) | Set volume in Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Stop](media/apple-music/apple-music-stop.applescript) | Stop Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Toggle Repeat](media/apple-music/apple-music-repeat.applescript) | Toggle repeat setting in Music. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-music/images/apple-music-logo.png?raw=true" width="20" height="20"> | [Toggle Shuffle](media/apple-music/apple-music-shuffle.applescript) | Toggle shuffle setting in Music. | [Caleb Stauffer](https://github.com/crstauf) |

#### Apple Tv

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-tv/images/apple-tv-logo.png?raw=true" width="20" height="20"> | [Pause](media/apple-tv/apple-tv-pause.applescript) | Pause TV. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-tv/images/apple-tv-logo.png?raw=true" width="20" height="20"> | [Play](media/apple-tv/apple-tv-play.applescript) | Play TV. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-tv/images/apple-tv-logo.png?raw=true" width="20" height="20"> | [Play Movie](media/apple-tv/apple-tv-play-movie.applescript) | Play specified movie from library in TV. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-tv/images/apple-tv-logo.png?raw=true" width="20" height="20"> | [Set Volume](media/apple-tv/apple-tv-set-volume.applescript) | Set volume in TV. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/apple-tv/images/apple-tv-logo.png?raw=true" width="20" height="20"> | [Stop](media/apple-tv/apple-tv-stop.applescript) | Stop TV. | [Caleb Stauffer](https://github.com/crstauf) |

#### Cmus

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| ℹ️ | [Current Track](media/cmus/track-info.sh) | Shows info on the current track if cmus is running | [mmerle](https://github.com/mmerle) |
| ⏩ | [Next Track](media/cmus/next-track.sh) | Goes forward a track if cmus is running | [mmerle](https://github.com/mmerle) |
| ⏪ | [Previous Track](media/cmus/previous-track.sh) | Goes back a track if cmus is running | [mmerle](https://github.com/mmerle) |
| ⏯ | [Toggle Play/Pause](media/cmus/play-pause.sh) | Toggles the play/pause state if cmus is running | [mmerle](https://github.com/mmerle) |
| 🔁 | [Toggle Repeat](media/cmus/toggle-repeat.sh) | Toggles the repeat option if cmus is running | [mmerle](https://github.com/mmerle) |
| 🔀 | [Toggle Shuffle](media/cmus/toggle-shuffle.sh) | Toggles the shuffle option if cmus is running | [mmerle](https://github.com/mmerle) |

#### Spotify

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Copy Current Playing Song URL](media/spotify/spotify-now-playing-url.applescript) | Get link to current Spotify playing song | [Jack LaFond](https://github.com/jacc) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Current Track](media/spotify/spotify-current-track.applescript) | Show currently playing track in Spotify. | [Thomas Paul Mann](https://github.com/thomaspaulmann) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Next Track](media/spotify/spotify-next-track.applescript) | Skips to the next track in Spotify. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Pause](media/spotify/spotify-pause.applescript) | Pause current track in Spotify. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Play](media/spotify/spotify-play.applescript) | Plays current track in Spotify. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Previous Track](media/spotify/spotify-previous-track.applescript) | Skips to the previous track in Spotify. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/media/spotify/images/spotify-logo.png?raw=true" width="20" height="20"> | [Toggle Play/Pause](media/spotify/spotify-play-pause.applescript) | Toggles play or pause of current track in Spotify. | Raycast |

## Navigation

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/images/justfocus.png?raw=true" width="20" height="20"> | [JustFocus](navigation/justfocus.applescript) | N/A | Jax0rz |
| 📂 | [Open Applications](navigation/open-applications.sh) | Opens the Applications folder in the Finder. | Raycast |
| 🖥 | [Open Clipboard URL on Desktop](navigation/open-desktop-url-from-clipboard.swift) | Opens the URL from the clipboard in the desktop app. | Raycast |
| 📟 | [Open Current Finder Directory in Terminal](navigation/open-terminal-from-finder.applescript) | Open current Finder directory in Terminal | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/images/iterm-logo.png?raw=true" width="20" height="20"> | [Open Current Finder Directory in iTerm](navigation/open-iterm-from-finder.applescript) | Open current Finder directory in iTerm | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 📟 | [Open Current Terminal Directory in Finder](navigation/open-finder-from-terminal.applescript) | Open curren Terminal directory in Finder | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/images/iterm-logo.png?raw=true" width="20" height="20"> | [Open Current iTerm Directory in Finder](navigation/open-finder-from-iterm.applescript) | Open current iTerm directory in Finder | [Kirill Gorbachyonok](https://github.com/japanese-goblinn) |
| 📂 | [Open Desktop](navigation/open-desktop.sh) | Opens the Desktop folder in the Finder. | Raycast |
| 📂 | [Open Documents](navigation/open-documents.sh) | Opens the Documents folder in the Finder. | Raycast |
| 📂 | [Open Downloads](navigation/open-downloads.sh) | Opens the Downloads folder in the Finder. | Raycast |
| 📂 | [Open Home](navigation/open-home.sh) | Opens the Home folder in the Finder. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/./images/pixelmator-pro-2.0.png?raw=true" width="20" height="20"> | [Open Image From Clipboard](navigation/open-clipboard-in-pixelmator-pro.applescript) | Creates a new document in Pixelmator Pro from the image stored in your clipboard. | [Bryce Carr](https://github.com/bdcarr) |
| 📂 | [Open Library](navigation/open-library.sh) | Opens the Library folder in the Finder. | Raycast |
| 🌐 | [Open URL From Clipboard](navigation/open-url-from-clipboard.sh) | Opens the URL in the clipboard. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/images/bear.png?raw=true" width="20" height="20"> | [Search in Bear](navigation/search-in-bear.sh) | N/A | Jax0rz |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/images/dash.png?raw=true" width="20" height="20"> | [Search in Dash](navigation/search-in-dash.sh) | N/A | Jax0rz |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/navigation/images/devdocs.png?raw=true" width="20" height="20"> | [Search in Devdocs](navigation/search-in-devdocs.sh) | N/A | Jax0rz |

## System

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📅 | [Copy Availability](system/copy-availability.swift) | Copies the calenadar availability of today. | Raycast |
| 💁 | [Copy Last Download](system/copy-last-download.swift) | Copy the last downloaded file to the clipboard. | Raycast |
| 📸 | [Copy Last Screenshot](system/copy-last-screenshot.swift) | Copies the last screenshot to the clipboard. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/system/images/new-file.png?raw=true" width="20" height="20"> | [Create New File in Finder](system/create-new-file-in-finder.applescript) | Create New File in Finder is a script to make your Finder better.You can use this script to create a plain text file. | Jax0rz |
| 📀 | [Eject All Disks](system/eject-all-disks.applescript) | Ejects all mounted disk images. | Raycast |
| 🗑 | [Empty Trash](system/empty-trash.applescript) | Empty the trash. | Raycast |
| 📈 | [Largest CPU Process](system/largest-cpu-process.sh) | Report process with largest system CPU usage. | [Caleb Stauffer](https://github.com/crstauf) |
| 📈 | [Largest RAM Process](system/largest-ram-process.sh) | Report process with largest system RAM usage. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/system/images/move-downloads-to-trash.png?raw=true" width="20" height="20"> | [Move Downloads to Trash](system/move-downloads-to-trash.applescript) | N/A | Jax0rz |
| 💁‍♂️ | [Open Last Download](system/open-last-download.swift) | Opens the last downloaded file. | Raycast |
| 💥 | [Quit All Applications](system/quit-all-apps.swift) | Quits all running applications except Finder and Raycast. | Raycast |
| 🖼️ | [Refresh Wallpaper](system/wallpaper-refresh.applescript) | Refresh the wallpaper of the main display's current [Space](https://support.apple.com/guide/mac-help/work-in-multiple-spaces-mh14112/mac). | [Caleb Stauffer](https://github.com/crstauf) |
| 🎧 | [Reload CoreAudio](system/reload-coreaudio.sh) | Reloads CoreAudio. | [Maxim Krouk](https://github.com/maximkrouk) |
| ♻️ | [Restart](system/restart.applescript) | Restarts computer. | Raycast |
| 🎨 | [Sample Colour](system/sample-colour.swift) | Sample a colour from anywhere on your screen. | [Jesse Claven](https://github.com/jesse-c) |
| 🌀 | [Screen Saver](system/screensaver.applescript) | A script command to start your current screen saver. | [Valentin Chrétien](https://twitter.com/valentinchrt) |
| 🛌 | [Shut Down](system/shutdown.applescript) | Shuts down computer. | Raycast |
| 😴 | [Sleep](system/sleep.applescript) | Puts computer to sleep. | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/system/images/bluetooth.png?raw=true" width="20" height="20"> | [Toggle Bluetooth](system/bluetooth.template.applescript) | Toggle your Bluetooth connection. | [Vincent Dörig](https://github.com/vincentdoerig) |
| 🖥 | [Toggle Desktop Icons](system/toggle-desktop-icons.applescript) | A script command to show and hide icons of Desktop folder | [Raycast](https://raycast.com) |
| 👓 | [Toggle Hidden Files](system/toggle-hidden-files.applescript) | Show and hide hidden files/folders which starts with "." (dot), i.e: .bash_rc, .ssh | [Thiago Holanda](https://twitter.com/tholanda) |
| 🌗 | [Toggle System Appearance](system/toggle-system-appearance.applescript) | Script Command to switch between the system appearance, light and dark mode. | [Thiago Holanda](https://twitter.com/tholanda) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/system/images/wifi-dark.png?raw=true" width="20" height="20"> | [Toggle Wi-Fi](system/wifi.template.applescript) | Toggle your Wi-Fi connection. | [Vincent Dörig](https://github.com/vincentdoerig) |
| 😴 | [Turn Off Do Not Disturb](system/dnd-off.sh) | Turn off "do not disturb" mode. Does [not work on Big Sur](https://github.com/sindresorhus/do-not-disturb-cli/issues/2). | [Caleb Stauffer](https://github.com/crstauf) |
| 😴 | [Turn On Do Not Disturb](system/dnd-on.sh) | Turn on "do not disturb" mode. Does [not work on Big Sur](https://github.com/sindresorhus/do-not-disturb-cli/issues/2). | [Caleb Stauffer](https://github.com/crstauf) |

## Web Searches

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| 📦 | [Bundlephobia cost](web-searches/bundlephobia.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| ❓ | [Caniuse.com search](web-searches/caniuse.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/giphy.png?raw=true" width="20" height="20"> | [Giphy search](web-searches/giphy.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/wpengine-logo.png?raw=true" width="20" height="20"> | [Open WP Engine Install](web-searches/wpengine-install.sh) | Open specified [WP Engine](https://wpengine.com) install. | [Caleb Stauffer](https://github.com/crstauf) |
| 📦 | [Open npm Package Repo](web-searches/repo.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/github-logo.png?raw=true" width="20" height="20"> | [Search GitHub](web-searches/search-github.sh) | Search [GitHub](https://github.com). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/go.png?raw=true" width="20" height="20"> | [Search Go Package Documentation](web-searches/pkg-go-dev.sh) | Search pkg.go.dev for package documentation | [Phil Salant](https://github.com/PSalant726) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/mozilla-developer-network.png?raw=true" width="20" height="20"> | [Search MDN (Mozilla Developer Network)](web-searches/mozilla-developer-network.sh) | N/A | [Jon Callahan](https://www.joncallahan.com) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/netflix-logo.png?raw=true" width="20" height="20"> | [Search Netflix](web-searches/search-netflix.sh) | Search Netflix. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/php-logo.png?raw=true" width="20" height="20"> | [Search PHP Docs](web-searches/search-php-docs.sh) | Search [PHP official documentation](https://www.php.net/docs.php). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/unsplash-logo.png?raw=true" width="20" height="20"> | [Search Unsplash](web-searches/search-unsplash.sh) | Search [Unsplash](https://unsplash.com). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/wpengine-logo.png?raw=true" width="20" height="20"> | [Search WP Engine Installs](web-searches/search-wpengine-installs.sh) | Search [WP Engine](https://wpengine.com) installs. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/cloudflare-logo.png?raw=true" width="20" height="20"> | [Search cdnjs](web-searches/search-cdnjs.sh) | Search [cdnjs.com](https://cdnjs.com/) for library. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/amazon.png?raw=true" width="20" height="20"> | [Search in Amazon](web-searches/amazon.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/baidu.png?raw=true" width="20" height="20"> | [Search in Baidu](web-searches/search-in-baidu.sh) | N/A | Jax0rz |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/bilibili.png?raw=true" width="20" height="20"> | [Search in Bilibili](web-searches/search-in-bilibili.sh) | N/A | Jax0rz |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/crunchbase.png?raw=true" width="20" height="20"> | [Search in Crunchbase](web-searches/crunchbase.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/duck-duck-go.png?raw=true" width="20" height="20"> | [Search in DuckDuckGo](web-searches/duck-duck-go.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/ecosia.png?raw=true" width="20" height="20"> | [Search in Ecosia](web-searches/ecosia.sh) | N/A | [Sasivarnan R](https://github.com/sasivarnan) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/figma.png?raw=true" width="20" height="20"> | [Search in Figma](web-searches/figma.sh) | Search files in Figma | [Tanguy Le Stradic](https://github.com/tanguyls) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/google.png?raw=true" width="20" height="20"> | [Search in Google](web-searches/google-search.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/mdn_light.png?raw=true" width="20" height="20"> | [Search in MDN (Mozilla) Docs by Topic](web-searches/mdn.sh) | Search in MDN (Mozilla) Docs by topic | [Jesse Traynham](https://github.com/traynham) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/taobao.png?raw=true" width="20" height="20"> | [Search in Taobao](web-searches/search-in-taobao.sh) | N/A | Jax0rz |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/twitter.png?raw=true" width="20" height="20"> | [Search in Twitter](web-searches/twitter-search.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/wikipedia.png?raw=true" width="20" height="20"> | [Search in Wikipedia](web-searches/search-in-wikipedia.sh) | N/A | Jax0rz |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/youtube.png?raw=true" width="20" height="20"> | [Search in YouTube](web-searches/youtube.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/zhihu.png?raw=true" width="20" height="20"> | [Search in Zhihu](web-searches/search-in-zhihu.sh) | N/A | Jax0rz |
| <img src="https://grep.app/favicon.ico" width="20" height="20"> | [Search in grep.app](web-searches/grep-app-search.sh) | N/A | Raycast |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/npmjs.png?raw=true" width="20" height="20"> | [Search npm Packages](web-searches/npmjs.sh) | N/A | Raycast |
| 🔗 | [Unfurl URL](web-searches/unfurl.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/ia-logo.jpg?raw=true" width="20" height="20"> | [Wayback Machine Search](web-searches/wayback-machine.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| 🐸 | [njt](web-searches/njt.sh) | N/A | [Zander Martineau](https://zander.wtf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/images/npms.png?raw=true" width="20" height="20"> | [npms](web-searches/npms.sh) | N/A | [Zander Martineau](https://zander.wtf) |

#### Wordpress

| Icon | Title | Description | Author |
| ---- | ----- | ----------- | ------ |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/wordpress/images/wordpress-logo.png?raw=true" width="20" height="20"> | [Search WordPress Docs](web-searches/wordpress/search-wordpress-docs.sh) | Search [WordPress Developer documentation](https://developer.wordpress.org/reference/). | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/wordpress/images/wordpress-logo.png?raw=true" width="20" height="20"> | [WordPress CLI Command](web-searches/wordpress/wordpress-cli-command.sh) | Open [WordPress CLI command reference](https://developer.wordpress.org/cli/commands/) for specified command. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/wordpress/images/wordpress-logo.png?raw=true" width="20" height="20"> | [WordPress Classes Reference](web-searches/wordpress/wordpress-classes-reference.sh) | Open [WordPress classes reference](https://developer.wordpress.org/reference/classes/) for specified class. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/wordpress/images/wordpress-logo.png?raw=true" width="20" height="20"> | [WordPress Functions Reference](web-searches/wordpress/wordpress-functions-reference.sh) | Open [WordPress functions reference](https://developer.wordpress.org/reference/functions/) for specified function. | [Caleb Stauffer](https://github.com/crstauf) |
| <img src="https://raw.githubusercontent.com/raycast/script-commands/master/commands/web-searches/wordpress/images/wordpress-logo.png?raw=true" width="20" height="20"> | [WordPress Hooks Reference](web-searches/wordpress/wordpress-hooks-reference.sh) | Open [WordPress hooks reference](https://developer.wordpress.org/reference/hooks/) for specified hook. | [Caleb Stauffer](https://github.com/crstauf) |

## Community

This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast.
If you have anything cool to show, please send us a pull request. If we screwed something up,
please report a bug. Join our
[Slack community](https://www.raycast.com/community)
to brainstorm ideas with like-minded folks.