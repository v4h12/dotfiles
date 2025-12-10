#!/bin/bash

WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
STYLE_FILE="$HOME/.cache/waybar-current-style"

if pgrep -x waybar > /dev/null; then
    killall waybar
else
    # Read which style was last used
    if [ -f "$STYLE_FILE" ]; then
        LAST_STYLE=$(cat "$STYLE_FILE")

        if [ "$LAST_STYLE" = "default" ] || [ -z "$LAST_STYLE" ]; then
            waybar & disown
        else
            waybar -s "$LAST_STYLE" & disown
        fi
    else
        # No saved style, use default
        waybar & disown
    fi
fi
