## Output modes

Here, you can browse the range of ways that Raycast lets you view your data, whether you need to display a range of items such as open pull requests, or whether you just need confirmation that your script has run successfully.

In `fullOutput` the entire output is presented on a separate view, similar to a terminal window. This is handy when your script generates output to consume.

![fullOutput mode](/images/screenshots/fulloutput-mode.png)

In `compact` mode the last line of the standard output is shown in the toast

![compact mode](/images/screenshots/compact-mode.png)

In `silent` mode the last line (if exists) will be shown in overlaying HUD toast after Raycast window is closed.

![silent mode](/images/screenshots/silent-mode.png)

In `inline` mode, the first line of output will be directly shown in the command item and automatically refresh according to the specified `refreshTime`. Tip: Set your dashboard items as favorites via the action menu in Raycast.
**NOTE:** `refreshTime` parameter is required for `inline` mode. When not specified, `compact` mode will be used instead.

![inline mode](/images/screenshots/inline-mode.png)

**🚨 Hint:** use `cmd k` to access extra functionality such as adding to favorites or reordering the root search preferences.

Please note that long-running tasks generating a lot of partial data are not supported for `compact`, `silent`, and `inline` modes. For example, the `zip` command generates a lot of partial logs when compressing folders with many files. Scripts using `zip` won't work on `compact`, `silent`, and `inline`; but they will work in `fullOutput`. To make it work in the other modes you need to use the `zip -q` flag.

# ANSI Supported Colors 🎨

We support colors for `inline` and `fullOutput` mode scripts for you to customize generated output by changing its background and foreground color.

![colors inline mode](/images/screenshots/inline-colours.png)

Escape code is in linux format: `0x1B`

Colors are adapted to current users appearance settings (light and dark themes)
| Color | # Foreground | # Background | Light | Dark |
| ------ | ------------ | ------------ | ----- | ---- |
| Black | 30 | 40 | #000000 | #000000 |
| Red | 31 | 41 | #B12424 | #FF6363 |
| Green | 32 | 42 | #006B4F | #59D499 |
| Yellow | 33 | 43 | #F8A300 | #FFC531 |
| Blue | 34 | 44 | #138AF2 | #56C2FF |
| Magenta | 35 | 45 | #9A1B6E | #CF2F98 |
| Cyan | 36 | 46 | #3EB8BF | #52EEE5 |
| White | 97 | 107 | #FFFFFF | #FFFFFF |

## Other colors

We also support [8-bit](https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit) and [24-bit](https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit) color codes if you need a wider range of colors.

**Other supported codes:**

| Code | Name |
| ---- | ---- |
| 0 | Reset (normal) |
| 4 | Underline |
| 9 | Crossed out |
| 24 | Not underlined |
| 29 | Not crossed out |

**💡Hint:** Unsupported terminal codes will be stripped out from output and ignored.

**Example:**

![colors inline mode](/images/screenshots/colour-example.png)
| Script | Code |
| ------ | ---- |
| bash | `echo -e '\033[31;42mred text on green background\033[0m'` |
| bash tput | `export TERM=linux; echo "$(tput setaf 1)$(tput setab 2)red text on green background$(tput sgr0)";` |
| swift | `print("\\u{001B}[31;42mred text on green background\\u{001B}[0m")` |
| osascript | `do shell script "echo '\\033[31;42mred text on green background\\033[0m'"`|
| node.js | `console.log('\x1b[31;42mred text on green background\x1b[0m')`
