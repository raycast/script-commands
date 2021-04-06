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

**Other supported codes:**

[Untitled](https://www.notion.so/550b81f90f9c48e385feba68a363abb6)

Unsupported terminal codes will be stripped out from output and ignored.

**Example:**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b7507f62-3718-4e51-b3ee-c2659d73f3cc/colours.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b7507f62-3718-4e51-b3ee-c2659d73f3cc/colours.png)

[Untitled](https://www.notion.so/40a837370fbc4eb68d41efbf9061de20)