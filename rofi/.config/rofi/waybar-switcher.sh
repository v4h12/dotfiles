#!/bin/bash

WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
CACHE_FILE="$HOME/.cache/waybar-current-style"
ROFI_COLORS_DIR="$HOME/.config/rofi/rofi_colors"
ROFI_COLORS_FILE="$HOME/.config/rofi/colors.rasi"
SWAYNC_CONFIG_DIR="$HOME/.config/swaync"

options="Default\nLight\nNavy\nMaroon\nCream\nTransparent\nDark-Transparent\nGrey\nCirc\nKanagawa\nRamude\nHoltee\nGreish\nGruv"
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Waybar Theme" -theme ~/.config/rofi/config.rasi)

[ -z "$chosen" ] && exit 0

STYLE=""
ROFI_STYLE=""
SWAYNC_STYLE=""

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
  SWAYNC_STYLE="grey-transparent-style.css"
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
  ROFI_STYLE="holtee"
  SWAYNC_STYLE="holtee.css"
  ;;
"Greish")
  STYLE="greish-style.css"
  ROFI_STYLE="greish"
  SWAYNC_STYLE="greish-style.css"
  ;;
"Gruv")
  STYLE="gruv-style.css"
  ROFI_STYLE="gruv"
  SWAYNC_STYLE="gruv-style.css"
  ;;
esac

[ -z "$STYLE" ] && exit 0

# Resolve and validate every target before touching the running waybar, so a
# missing file leaves the current bar alone instead of killing it for good.
STYLE_PATH="$WAYBAR_CONFIG_DIR/$STYLE"
ROFI_STYLE_PATH="$ROFI_COLORS_DIR/$ROFI_STYLE.rasi"
SWAYNC_STYLE_PATH="$SWAYNC_CONFIG_DIR/$SWAYNC_STYLE"

if [ ! -f "$STYLE_PATH" ]; then
  notify-send "Waybar Theme" "Missing $STYLE_PATH - waybar left running" --urgency=critical
  exit 1
fi

# Switch Waybar style
mkdir -p "$(dirname "$CACHE_FILE")"
echo "$STYLE_PATH" >"$CACHE_FILE"
pkill -x waybar
for _ in 1 2 3 4 5 6 7 8 9 10; do
  pgrep -x waybar >/dev/null || break
  sleep 0.1
done
waybar -s "$STYLE_PATH" &
disown

applied="waybar"
problems=""

# Switch Rofi colors
if [ -f "$ROFI_STYLE_PATH" ]; then
  ln -sf "$ROFI_STYLE_PATH" "$ROFI_COLORS_FILE"
  applied="$applied, rofi"
else
  problems="rofi (no $ROFI_STYLE.rasi)"
fi

# Switch SwayNC style
if [ ! -f "$SWAYNC_STYLE_PATH" ]; then
  problems="${problems:+$problems, }swaync (no $SWAYNC_STYLE)"
elif ! pidof swaync >/dev/null; then
  cp "$SWAYNC_STYLE_PATH" "$SWAYNC_CONFIG_DIR/style.css"
  problems="${problems:+$problems, }swaync (not running)"
else
  cp "$SWAYNC_STYLE_PATH" "$SWAYNC_CONFIG_DIR/style.css"
  swaync-client -rs # Reload SwayNC to apply new style
  applied="$applied, swaync"
fi

if [ -z "$problems" ]; then
  notify-send "Waybar Theme" "$chosen theme activated ($applied)"
else
  notify-send "Waybar Theme" "$chosen: $applied ok, skipped $problems" --urgency=critical
fi
