#!/usr/bin/bash

set -eou pipefail

if ! pgrep -x "tmux: server" > /dev/null; then
    notify-send "tmux" "no server running"
    exit 0
else
    # if tmux list-sessions &>/dev/null; then
        SESSION=$(
            tmux list-sessions -F "#{session_name}" |
            rofi -dmenu -p "Select Session" \
            -theme ~/.config/rofi/config.rasi
        )
        kitty tmux attach-session -t "$SESSION"
    # fi
fi
