# Brightness

## You can edit this file directly:

`/usr/lib/pm-utils/sleep.d/999brightness`

## Or run these commands:

> Shows you the monitors

`xrandr | grep connected | cut -f1 -d" "`

### Yours are LVDS-1 and DP-1

> Then run

`xrandr --output LVDS-1 --brightness 0.7`

`xrandr --output DP-1 --brightness 0.7`