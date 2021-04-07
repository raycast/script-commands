In `fullOutput` the entire output is presented on a separate view, similar to a terminal window. This is handy when your script generates output to consume.

![fullOutput mode](./images/screenshots/fulloutput.png)

In `compact` mode the last line of the standard output is shown in the toast

![compact mode](./images/screenshots/compactMode.png)

In `silent` mode the last line (if exists) will be shown in overlaying HUD toast after Raycast window is closed.

![silent mode](./images/screenshots/silentMode.png)

In `inline` mode, the first line of output will be directly shown in the command item and automatically refresh according to the specified `refreshTime`. Tip: Set your dashboard items as favourites via the action menu in Raycast

![inline mode](./images/screenshots/inlineMode.png)

🚨 Hint: use `cmd k` to access extra functionality such as adding to favourites or reordering the root search preferences.

# ANSII Supported Colours 🎨

We support colours for `inline` and `fullOutput` mode scripts for you to customise generated output by changing its background and foreground colour.

![colours inline mode](./images/screenshots/inlineColours.png)

Escape code is in linux format: `0x1B`

Colours are adapted to current users apperance settings (light and dark themes)
| Colour | # Foreground | # Background | Light | Dark |
| ------ | ------------ | ------------ | ----- | ---- |
| Black | 30 | 40 | #000000 | #000000 |
| Red | 31 | 41 | #B12424 | #FF6363 |
| Green | 32 | 42 | #006B4F | #59D499 |
| Yellow | 33 | 43 | #F8A300 | #FFC531 |
| Blue | 34 | 44 | #138AF2 | #56C2FF |
| Magenta | 35 | 45 | #9A1B6E | #CF2F98 |
| Cyan | 36 | 46 | #3EB8BF | #52EEE5 |
| White | 97 | 107 | #FFFFFF | #FFFFFF |

**Other supported codes:**

| Code | Name |
| ---- | ---- |
| 0 | Reset (normal) |
| 4 | Underline |
| 9 | Crossed out |
| 24 | Not underlined |
| 29 | Not crossed out |

💡 Unsupported terminal codes will be stripped out from output and ignored.

**Example:**

![colours inline mode](./images/screenshots/colour-example.png)
| Script | Code |
| ------ | ---- |
| bash | `echo -e '\\033[31;42mred text on green background\\033[0m'` |
| bash tput | `export TERM=linux; echo "$(tput setaf 1)$(tput setab 2)red text on green background$(tput sgr0)";` |
| swift | `print("\\u{001B}[31;42mred text on green background\\u{001B}[0m")` |
