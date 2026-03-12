#!/bin/bash

# Get all windows in special workspaces with their effective class names (using title for kitty specifics)
windows=$(hyprctl clients -j | jq -r '
  .[] |
  select(.workspace.name | startswith("special")) |
  if .class == "kitty" then
    if .title | ascii_downcase | contains("yazi") then "yazi"
    elif .title | ascii_downcase | contains("rmpc") then "rmpc"
    # elif .title | ascii_downcase | contains("Volume Control") then "Volume Control"
    else .class
    end
  else .class
  end
' | sort -u)

# Map common application classes to icons (nerd fonts)
get_icon() {
  case "$1" in
  foot | kitty | alacritty) echo "󰆍" ;;
  firefox | Firefox) echo "󰈹" ;;
  chromium | chrome | brave) echo "󰊯" ;;
  qutebrowser | Qutebrowser | org.qutebrowser.qutebrowser) echo " " ;;
  zathura | Zathura | org.pwmt.zathura | okular | evince) echo "" ;;
  thunar | nautilus | dolphin | pcmanfm) echo "" ;;
  org.pulseaudio.pavucontrol | Volume\ Control) echo "" ;;
  nm-connection-editor) echo "󱘖" ;;
  virt-manager) echo "" ;;
  discord | Discord) echo "󰙯" ;;
  code | Code | code-oss | VSCodium) echo "󰨞" ;;
  obsidian | Obsidian) echo "󱞁" ;;
  artha | Artha) echo "󰘝" ;;
  sqlite | sqlitebrowser) echo "" ;;
  steam | Steam) echo "󰓓" ;;
  yazi) echo "" ;; # Example: folder icon for yazi (file manager)
  rmpc) echo "󰲹" ;; # Example: music note for rmpc (music client)
  *) echo "" ;;     # Default window icon
  esac
}

# Build icon list
icons=""
tooltip=""
first=true
while IFS= read -r class; do
  [ -z "$class" ] && continue
  icon=$(get_icon "$class")
  icons="$icons $icon"
  # Add newline before each entry except the first
  if [ "$first" = true ]; then
    tooltip="$class"
    first=false
  else
    tooltip="$tooltip\n$class"
  fi
done <<<"$windows"

# Format output
if [ -z "$icons" ]; then
  echo '{"text": "", "tooltip": "", "class": "empty"}'
else
  count=$(echo "$windows" | wc -l)
  echo "{\"text\": \"$icons\", \"tooltip\": \"$tooltip\", \"class\": \"occupied\"}"
fi
