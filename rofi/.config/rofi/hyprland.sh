#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

DIRS=$(
  grep -E '^[[:space:]]*source[[:space:]]*=' "$HYPR_CONF" |
    sed -E 's/^[[:space:]]*source[[:space:]]*=[[:space:]]*//; s/"//g; s/\r//' |
    while read -r line; do
      echo "${line/#\~/$HOME}"
    done
)

if [ -z "$DIRS" ]; then
  echo "No Sources found in $HYPR_CONF" | rofi -dmenu -p "Error" -theme ~/.config/rofi/launchers/type-1/style-5.rasi
  exit 1
fi

# CHOICE=$(echo "$DIRS" | rofi -dmenu -p "Hypr Configs" -theme ~/.config/rofi/launchers/type-1/style-5.rasi)
CHOICE=$(echo "$DIRS" | rofi -dmenu -p "Hypr Configs" -theme ~/.config/rofi/config.rasi)

if [ -n "$CHOICE" ]; then
  kitty -e nvim "$CHOICE"
fi
