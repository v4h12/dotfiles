#!/usr/bin/env sh

if pgrep -x "hypridle" > /dev/null; then
    pkill hypridle
    notify-send "Idle" "Idle-Inhibitor deactivated"
else
    hypridle -c ~/.config/hypr/hypridle.conf &
    notify-send "Idle" "Idle-Inhibitor activated"
fi
