#!/bin/bash

# Waybar
STYLE=$(cat ~/.cache/waybar-current-style 2>/dev/null)
[ -n "$STYLE" ] && [ -f "$STYLE" ] && waybar -s "$STYLE" & || waybar &

# Hyprpaper
WALL=$(cat ~/.cache/current-wallpaper 2>/dev/null)
if [ -n "$WALL" ] && [ -f "$WALL" ]; then
  hyprpaper &
  while ! hyprctl hyprpaper listloaded &>/dev/null; do sleep 0.1; done
  hyprctl hyprpaper preload "$WALL"
  while ! hyprctl hyprpaper listloaded | grep -qF "$WALL"; do sleep 0.1; done
  hyprctl hyprpaper wallpaper ",$WALL"
fi
