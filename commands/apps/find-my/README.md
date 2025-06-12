# Find My Phone Raycast

I lose my phone often, so I made this.

This is a Node.js script that uses Playwright to automate iCloud Find My and trigger a sound on your Apple device. It's perfect for people like me who misplace their phones and want a quick, automated way to make them ring—with Raycast.

## Usage

```sh
git clone https://github.com/vsvaidya27/fmp-raycast
cd fmp-raycast
npm install
cp .env.example .env
# Edit .env with your real credentials
chmod +x fmp.js
```

### Add to Raycast

1. Open Raycast and go to **Extensions**.
2. Click **Add**.
3. Select **Add Script Directory**.
4. Choose the `fmp-raycast` directory you just cloned.
5. Set fmp as your alias for calling the script.

Now you can trigger the script directly from Raycast!

## How it works

- Automates login to iCloud Find My using Playwright
- Selects your device by name
- Triggers the "Play Sound" feature to help you locate your device

**Note:** You'll need to provide your iCloud credentials and device name in the `.env` file. Sometimes a 2FA check may pop up, but usually they allow you to bypass this and manual intervention is not neccesary (since you often need the very thing you are trying to find for 2FA).

---

## 🛠 Troubleshooting

### If you get the error `env: node: No such file or directory`

Raycast uses a limited shell environment, so it may not find your Node.js install.

To fix it:

1. Run this in Terminal to find your full Node path:
   ```bash
   which node
   ```
2. Edit the top of `fmp.js`:
   Replace:
   ```sh
   #!/usr/bin/env node
   ```
   With:
   ```sh
   #!/full/path/to/node
   ```
