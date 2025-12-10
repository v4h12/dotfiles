#!/bin/bash
# Start idle timer
swayidle \
  timeout 1800 'hyprlock'
# 30 minutes → lock screen
timeout 10800 'systemctl suspend'
# 3 hours → suspend
before-sleep 'hyprctl dispatch exec "hyprlock"'
# Lock before suspend
lock 'hyprctl dispatch exec "hyprlock"'
# Lock immediately if triggered
ignore-empty-output
