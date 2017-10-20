# How to Remap Keys in Ubuntu

> This approach relies upon a program to listen for keys events and then dispatching the key combo you want using a virtual keybard

1. `sudo apt install xvkbd` This is the virtual keyboard
2. `sudo apt install xbindkeys` This is the listener
3. `sudo apt install xbindkeys-config` This is the listener gui

* The data goes into your `.xbindkeysrc` file in your home dir

Here is an example:

```bash
#Select Left
"xvkbd -xsendevent -text "\C\S\[Left]""
    Control+Shift+Mod2+Mod5 + j

#Select Right
"xvkbd -xsendevent -text "\C\S\[Right]""
    Control+Shift+Mod2+Mod5 + l
```

* The above simply listens for the meta key + control + shift and sends a select left and select right text command with the virtual keyboard

* After modifying your `.xbindkeysrc` file you must kill the xbindkeys process with `pkill -9 xbindkeys` and then rerun it with `xbindkeys` 
  * If you want to verify it is running you can do `pgrep xbindkeys` which will output the **pid**
