#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current-wallpaper"
CURRENT_LINK="$HOME/.config/hypr/current_wallpaper"
# Check dependencies
for cmd in hyprctl hyprpaper rofi notify-send jq; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "Error: $cmd not found"
    exit 1
  }
done
# Ensure wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "Error" "Wallpaper directory not found: $WALLPAPER_DIR"
  exit 1
fi
# Wait for Hyprland to be ready (useful at startup)
wait_for_hyprland() {
  local timeout=30
  while ! hyprctl monitors >/dev/null 2>&1 && [ $timeout -gt 0 ]; do
    sleep 0.2
    ((timeout--))
  done
  [ $timeout -gt 0 ]
}
# Wait for hyprpaper to be ready
wait_for_hyprpaper() {
  local timeout=50
  while ! pgrep -x hyprpaper >/dev/null && [ $timeout -gt 0 ]; do
    sleep 0.1
    ((timeout--))
  done
  [ $timeout -gt 0 ]
}
# List all image files and add "None" option
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
mkdir -p "$THUMB_DIR"

options=""
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$img" ] || continue
  name=$(basename "$img")
  thumb="$THUMB_DIR/$name.png"

  if [ ! -f "$thumb" ]; then
    convert "$img" -thumbnail 300x200^ -gravity center -extent 300x200 "$thumb" 2>/dev/null
  fi

  options+="$name\0icon\x1f$thumb\n"
done

# chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Wallpaper" -theme ~/.config/rofi/launchers/type-1/style-10.rasi)
chosen=$(printf "None\n%b" "$options" | rofi -dmenu -i -p "Select Wallpaper" \
  -theme ~/.config/rofi/config.rasi \
  -show-icons \
  -theme-str 'element-icon { size: 8em; }' \
  -theme-str 'listview { columns: 3; lines: 3; }')
# Exit if nothing selected
[ -z "$chosen" ] && exit 0
if [ "$chosen" = "None" ]; then
  killall hyprpaper 2>/dev/null
  rm -f "$CACHE_FILE" "$CURRENT_LINK"
  notify-send "Wallpaper Removed" "Hyprpaper stopped"
else
  WALLPAPER_PATH="$WALLPAPER_DIR/$chosen"
  # Verify the file exists
  if [ ! -f "$WALLPAPER_PATH" ]; then
    notify-send "Error" "Wallpaper file not found"
    exit 1
  fi
  # Ensure Hyprland is ready
  if ! wait_for_hyprland; then
    notify-send "Error" "Hyprland not responding"
    exit 1
  fi
  # Start hyprpaper if not running
  if ! pgrep -x hyprpaper >/dev/null; then
    hyprpaper &
    if ! wait_for_hyprpaper; then
      notify-send "Error" "Failed to start hyprpaper"
      exit 1
    fi
  fi
  # Unload previous wallpaper
  if [ -f "$CACHE_FILE" ]; then
    PREV_WALLPAPER=$(cat "$CACHE_FILE")
    [ -n "$PREV_WALLPAPER" ] && hyprctl hyprpaper unload "$PREV_WALLPAPER" 2>/dev/null
  fi
  # Load new wallpaper
  hyprctl hyprpaper preload "$WALLPAPER_PATH"
  # Apply to all monitors
  MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
  for MON in $MONITORS; do
    hyprctl hyprpaper wallpaper "$MON,$WALLPAPER_PATH"
  done
  # Update cache and symlink
  ln -sf "$WALLPAPER_PATH" "$CURRENT_LINK"
  echo "$WALLPAPER_PATH" >"$CACHE_FILE"
  notify-send "Wallpaper Changed" "$chosen"
fi
