#!/usr/bin/env sh

FILEPATH=~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
grim "$FILEPATH" && notify-send "Screenshot saved" "$FILEPATH"

# grim ~/Pictures/Screenshots/"$(date +%Y%m%d_%H%M%S).png && notify-send "Screenshot saved""
