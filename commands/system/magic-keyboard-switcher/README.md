# magic-keyboard-switcher
Script command to easility switch the bluetooth connectivity of a single Magic Keyboard between several computers.

## How to setup

1. Install [blueutil](https://github.com/toy/blueutil). You can use [brew](https://brew.sh/) - `brew install blueutil`
2. Find out your Magic Keyboard bluetooth MAC address. With the keyboard connected, keep the Option key pressed while you click on your status bar bluetooth icon.
<div align="center">
  <img src="images/bluetooth menu.png" alt="Bluetooth menu" width="75%">
</div>

3. Open the script file, set your Magic Keyboard bluetooth MAC address in the `BTMAC` variable and review the blueutil binary location set in the `BIN` variable.
4. Remove `.template` from the file name.
5. Say Ok when prompted about giving Bluetooth permissions to Raycast after executing the script command.

## How to switch the Magic Keyboard between computers

It's desirable to have Raycast and this script command installed in both computers. 

First, run the script command in the one that has the keyboard currently connected. It will disconnect it and make it discoverable.
Second, run the script command in the other computer. It should connect it.
