## Arguments

Raycast allows you to set arguments for your script to enable you to do things like set items on a todo list or search Google for specified terms.

Use `argument[1..3]` metadata to specify custom arguments that will be displayed as inputs in the search bar when the script is selected.

![Custom arguments](/images/screenshots/custom-arguments.png)
The value of the argument metadata parameter should be valid json with these fields:
| Field | Description | Required | App Version |
| ----- | ----------- | -------- | ----------- |
| type | The argument type. We currently support `"text"`, `"password"` (for secure entry), and `"dropdown"`. When the type is `password`, entered text will be replaced with asterisks. Most common use case – passing passwords or secrets to commands. | ✅ | 1.64.0+ |
| placeholder | Placeholder for the input field. | ✅ | 1.2.0+ |
| optional | Set to `true` if you want to mark the argument as optional. When not provided, the argument is considered to be required (Raycast will not allow executing the script if the argument input is empty) | | 1.3.0+ |
| percentEncoded | Set to `true` if you want Raycast to perform percent-encoding on the argument value before passing it to the script. Can be handy for scripts that pass the argument directly to URL query | | 1.4.0+ |
| data | An array of objects with `title` and `value` properties, e.g.: `[{"title": "Item 1", "value": "1"}]` | ✅ when `type` is `dropdown`. | 1.64.0+ |
| ~~secure~~ | Deprecated in favor of `"type" = "password"` | | 1.18.0+ |

💡 **Maximum number of arguments:** 3 (if you have a use case that requires more, please let us know via feedback or in the [Slack community](https://www.raycast.com/community))

Here's an example of a simple web search script with two arguments:

```
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Flights
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🛩
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "from city", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "to city", "optional": true, "percentEncoded": true }

open "https://www.google.com/search?q=flights%20from%20$1%20to%20$2"

```

💡**Pro tip:** When typing alias + space, Raycast will automatically move focus to the first input field.
