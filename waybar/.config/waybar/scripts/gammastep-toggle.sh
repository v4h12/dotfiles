#!/bin/bash

if pgrep -x gammastep > /dev/null; then
    killall gammastep
    notify-send "Gammastep" "Disabled"
else
    gammastep -c ~/.config/gammastep/config.ini &
    notify-send "Gammastep" "Enabled"
fi
