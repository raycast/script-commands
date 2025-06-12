#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Find My Phone (Auto Sound)
// @raycast.mode silent
// @raycast.packageName FindMy
// @raycast.icon images/find-my-icon.png

require('dotenv').config();
const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: false });
  const page = await browser.newPage();

  // 1. Go to iCloud Find Devices
  await page.goto('https://www.icloud.com/find');

  // 2. Click "Sign In"
  await page.waitForSelector('text=Sign In', { timeout: 20000 });
  await page.click('text=Sign In');

  // 3. Wait for the Apple login iframe to appear
  const frameLocator = page.frameLocator('iframe[name="aid-auth-widget"]');

  // 4. Wait for the email/phone input inside the iframe
  await frameLocator.getByRole('textbox', { name: 'Email or Phone Number' }).waitFor({ timeout: 20000 });

  // 5. Fill in the email/phone
  await frameLocator.getByRole('textbox', { name: 'Email or Phone Number' }).fill(process.env.ICLOUD_EMAIL);

  // 6. Click the right-arrow button
  await frameLocator.getByRole('button').first().click();

  // 7. Wait for the "Continue with Password" button to appear, then click it
  await frameLocator.getByRole('button', { name: /Continue with Password/i }).waitFor({ timeout: 20000 });
  await frameLocator.getByRole('button', { name: /Continue with Password/i }).click();

  // 8. Wait for password input
  await frameLocator.getByRole('textbox', { name: 'Password' }).waitFor({ timeout: 20000 });
  await frameLocator.getByRole('textbox', { name: 'Password' }).fill(process.env.ICLOUD_PASSWORD);

  // 9. Click the arrow button to continue
  await frameLocator.getByRole('button').first().click();

  // 10. Wait for 2FA if needed; Hopefully not because this kinda defeats the purpose of automation even though its prob for the best security-wise :(
  console.log('If prompted, please complete 2FA in the browser window. :(');

  // 12. Click on your iPhone using the precise selector inside the second iframe
  await page.locator('iframe').nth(1).contentFrame().getByTitle(process.env.DEVICE).getByTestId('show-device-name').click();

  // 13. Wait for the device details panel to load
  await page.waitForTimeout(2000);

  // 14. Click the "Play Sound" button
  await page.locator('iframe').nth(1).contentFrame().getByRole('button', { name: 'Play Sound' }).click();

  console.log('✅ Play Sound triggered for ' + process.env.DEVICE + '!');
  await browser.close();
})();

