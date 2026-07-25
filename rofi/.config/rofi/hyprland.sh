#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.lua"
CONFIG_DIR="$HOME/.config/hypr"

DIRS=$(
    grep -E '^[[:space:]]*require\(' "$HYPR_CONF" |
    sed -E 's/.*require\("([^"]+)"\).*/\1/' |
    while read -r module; do
        echo "$CONFIG_DIR/$module.lua"
    done
)

if [ -z "$DIRS" ]; then
    echo "No Lua modules found in $HYPR_CONF" |
        rofi -dmenu -p "Error" -theme ~/.config/rofi/config.rasi
    exit 1
fi

CHOICE=$(
    echo "$DIRS" |
    rofi -dmenu -p "Hypr Lua Configs" \
    -theme ~/.config/rofi/config.rasi
)

if [ -n "$CHOICE" ]; then
    if tmux list-sessions &>/dev/null; then
        SESSION=$(
            tmux list-sessions -F "#{session_name}" |
            rofi -dmenu -p "Select Session" \
            -theme ~/.config/rofi/config.rasi
        )
        [ -n "$SESSION" ] && tmux send-keys -t "$SESSION" "nvim '$CHOICE'" Enter
    else
        kitty -e nvim "$CHOICE"
    fi
fi
