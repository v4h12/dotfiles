#!/bin/bash

CACHE_FILE="$HOME/.cache/current-wallpaper"

[ -f "$CACHE_FILE" ] || exit 0

WALLPAPER=$(cat "$CACHE_FILE")

[ -f "$WALLPAPER" ] || exit 0

# wait for hyprpaper
timeout=50
while ! pgrep -x hyprpaper >/dev/null && [ $timeout -gt 0 ]; do
    sleep 0.1
    ((timeout--))
done

hyprctl hyprpaper preload "$WALLPAPER"

MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
for MON in $MONITORS; do
    hyprctl hyprpaper wallpaper "$MON,$WALLPAPER"
done
