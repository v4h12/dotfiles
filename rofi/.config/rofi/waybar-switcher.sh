#!/bin/bash

WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
CACHE_FILE="$HOME/.cache/waybar-current-style"
ROFI_COLORS_DIR="$HOME/.config/rofi/waybar_colors"
ROFI_COLORS_FILE="$HOME/.config/rofi/colors.rasi"

options="Default\nLight\nNavy\nMaroon\nCream\nTransparent\nDark-Transparent\nGrey-Transparent\nCirc\nKanagawa"
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Waybar Theme" -theme ~/.config/rofi/launchers/type-1/style-10.rasi)

if [ -n "$chosen" ]; then
  killall waybar
  sleep 0.2

  case "$chosen" in
  "Default")
    STYLE="style.css"
    ROFI_STYLE="default"
    ;;
  "Light")
    STYLE="light-style.css"
    ROFI_STYLE="light"
    ;;
  "Navy")
    STYLE="navy-style.css"
    ROFI_STYLE="navy"
    ;;
  "Maroon")
    STYLE="maroon-style.css"
    ROFI_STYLE="maroon"
    ;;
  "Cream")
    STYLE="cream-style.css"
    ROFI_STYLE="cream"
    ;;
  "Transparent")
    STYLE="transparent-style.css"
    ROFI_STYLE="transparent"
    ;;
  "Dark-Transparent")
    STYLE="dark-transparent-style.css"
    ROFI_STYLE="dark-transparent"
    ;;
  "Grey-Transparent")
    STYLE="grey-transparent-style.css"
    ROFI_STYLE="grey-transparent"
    ;;
  "Circ")
    STYLE="circ-style.css"
    ROFI_STYLE="circ"
    ;;
  "Kanagawa")
    STYLE="kanagawa-style.css"
    ROFI_STYLE="kanagawa"
    ;;

  esac

  if [ -n "$STYLE" ]; then
    # Switch Waybar style
    STYLE_PATH="$WAYBAR_CONFIG_DIR/$STYLE"
    echo "$STYLE_PATH" >"$CACHE_FILE"
    waybar -s "$STYLE_PATH" &
    disown

    # Switch Rofi colors
    ROFI_STYLE_PATH="$ROFI_COLORS_DIR/$ROFI_STYLE.rasi"
    if [ -f "$ROFI_STYLE_PATH" ]; then
      ln -sf "$ROFI_STYLE_PATH" "$ROFI_COLORS_FILE"
    fi

    notify-send "Waybar Theme" "$chosen theme activated"
  fi
fi
