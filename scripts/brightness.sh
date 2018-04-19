#!/bin/bash

monitors=$(xrandr | grep connected | cut -f1 -d" ")

for X in $monitors
do
	xrandr --output "$X" --brightness $1
done