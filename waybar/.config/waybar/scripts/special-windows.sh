#!/bin/bash

# Get all windows in special workspaces with their class names
windows=$(hyprctl clients -j | jq -r '
  .[] |
  select(.workspace.name | startswith("special")) |
  .class
' | sort -u)

# Map common application classes to icons (nerd fonts)
get_icon() {
  case "$1" in
  foot | kitty | alacritty) echo "󰆍" ;;  # Terminal
  firefox | Firefox) echo "󰈹" ;;         # Firefox
  chromium | chrome | brave) echo "󰊯" ;; # Chrome/Chromium
  qutebrowser | Qutebrowser | org.qutebrowser.qutebrowser) echo " " ;;
  zathura | Zathura | org.pwmt.zathura | okular | evince) echo "" ;; # PDF viewer
  thunar | nautilus | dolphin | pcmanfm) echo "" ;;                   # File manager
  discord | Discord) echo "󰙯" ;;                                      # Discord
  code | Code | code-oss | VSCodium) echo "󰨞" ;;                      # VS Code
  obsidian | Obsidian) echo "󱞁" ;;                                    # Obsidian
  artha | Artha) echo "󰘝" ;;
  sqlite | sqlitebrowser) echo "" ;;
  steam | Steam) echo "󰓓" ;;
  *) echo "" ;; # Default window icon
  esac
}

# Build icon list
icons=""
tooltip=""
while IFS= read -r class; do
  [ -z "$class" ] && continue
  icon=$(get_icon "$class")
  icons="$icons $icon"
  tooltip="$tooltip$class\n"
done <<<"$windows"

# Format output
if [ -z "$icons" ]; then
  echo '{"text": "", "tooltip": "", "class": "empty"}'
else
  count=$(echo "$windows" | wc -l)
  echo "{\"text\": \"$icons\", \"tooltip\": \"$tooltip\", \"class\": \"occupied\"}"
fi
