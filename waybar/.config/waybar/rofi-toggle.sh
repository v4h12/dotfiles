#!/bin/bash

# Check if rofi is running
if pgrep -x "rofi" > /dev/null; then
    # If rofi is running, kill it
    pkill rofi
else
    # If rofi is not running, start it
    ~/.config/rofi/launchers/type-1/launcher.sh & disown
fi


