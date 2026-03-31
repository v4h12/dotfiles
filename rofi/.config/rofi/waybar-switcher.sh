#!/bin/bash

WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
CACHE_FILE="$HOME/.cache/waybar-current-style"
# ROFI_COLORS_DIR="$HOME/.config/rofi/waybar_colors"
ROFI_COLORS_DIR="$HOME/.config/rofi/rofi_colors"
ROFI_COLORS_FILE="$HOME/.config/rofi/colors.rasi"
SWAYNC_CONFIG_DIR="$HOME/.config/swaync"

options="Default\nLight\nNavy\nMaroon\nCream\nTransparent\nDark-Transparent\nGrey\nCirc\nKanagawa\nRamude\nHoltee\nGreish"
# chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Waybar Theme" -theme ~/.config/rofi/launchers/type-1/style-10.rasi)
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Waybar Theme" -theme ~/.config/rofi/config.rasi)

if [ -n "$chosen" ]; then
  killall waybar
  sleep 0.2

  case "$chosen" in
  "Default")
    STYLE="style.css"
    ROFI_STYLE="default"
    SWAYNC_STYLE="dark-style.css"
    ;;
  "Light")
    STYLE="light-style.css"
    ROFI_STYLE="light"
    SWAYNC_STYLE="light-style.css"
    ;;
  "Navy")
    STYLE="navy-style.css"
    ROFI_STYLE="navy"
    SWAYNC_STYLE="navy-style.css"
    ;;
  "Maroon")
    STYLE="maroon-style.css"
    ROFI_STYLE="maroon"
    SWAYNC_STYLE="maroon-style.css"
    ;;
  "Cream")
    STYLE="cream-style.css"
    ROFI_STYLE="cream"
    SWAYNC_STYLE="cream-style.css"
    ;;
  "Transparent")
    STYLE="transparent-style.css"
    ROFI_STYLE="transparent"
    SWAYNC_STYLE="transparent-style.css"
    ;;
  "Dark-Transparent")
    STYLE="dark-transparent-style.css"
    ROFI_STYLE="dark-transparent"
    SWAYNC_STYLE="dark-transparent-style.css"
    ;;
  "Grey")
    STYLE="grey-style.css"
    ROFI_STYLE="grey"
    SWAYNC_STYLE="grey-style.css"
    ;;
  "Circ")
    STYLE="circ-style.css"
    ROFI_STYLE="circ"
    SWAYNC_STYLE="circ-style.css"
    ;;
  "Ramude")
    STYLE="ramude-style.css"
    ROFI_STYLE="ramude"
    SWAYNC_STYLE="ramude-style.css"
    ;;

  "Kanagawa")
    STYLE="kanagawa-style.css"
    ROFI_STYLE="kanagawa"
    SWAYNC_STYLE="kanagawa-style.css"
    ;;

  "Holtee")
    STYLE="holtee-style.css"
    ROFI_STYLE="default"
    SWAYNC_STYLE="dark-style.css"
    ;;

  "Greish")
    STYLE="greish-style.css"
    # ROFI_STYLE="dark-transparent"
    ROFI_STYLE="greish"
    SWAYNC_STYLE="dark-transparent-style.css"
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

    # Switch SwayNC style
    SWAYNC_STYLE_PATH="$SWAYNC_CONFIG_DIR/$SWAYNC_STYLE"
    if [ -f "$SWAYNC_STYLE_PATH" ]; then
      cp "$SWAYNC_STYLE_PATH" "$SWAYNC_CONFIG_DIR/style.css"
      swaync-client -rs # Reload SwayNC to apply new style
    fi

    notify-send "Waybar Theme" "$chosen theme activated"
  fi
fi
