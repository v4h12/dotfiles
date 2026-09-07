#!/usr/bin/env sh

# Prompt for name, default to timestamp
name=$(rofi -dmenu -p "Screenshot name (blank = auto):")
[ -z "$name" ] && name=$(date +'%Y-%m-%d_%H-%M-%S')

# Select region and capture
region=$(slurp)
[ -z "$region" ] && exit 0

FILEPATH=~/Pictures/Screenshots/"$name".png
grim -g "$region" "$FILEPATH" && notify-send "Screenshot saved" "$FILEPATH" && zathura "$FILEPATH"
