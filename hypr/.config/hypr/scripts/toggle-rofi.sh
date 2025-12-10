#!/bin/bash
if pgrep -x rofi > /dev/null; then
	killall rofi
else
	# ~/.config/rofi/launchers/type-1/launcher.sh & disown
	rofi -show drun
fi
