#!/usr/bin/env sh


# sh -c \'name="$(rofi -dmenu -p "Screenshot name (blank = auto):"); [ -z "$name" ]" && name=$(date +\'%Y-%m-%d_%H-%M-%S\'); region=$(slurp); [ -n "$region" ] && grim -g "$region" ~/Pictures"$name".png && notify-send "Screenshot-snippet saved: $name.png"\'

# -- hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +\'%Y-%m-%d_%H-%M-%S\').png && notify-send "Screenshot-snippet saved"'))

sh -c \'name=$(rofi -dmenu -p "Screenshot name (blank = auto):"); [ -z "$name" ] && name=$(date +\'%Y-%m-%d_%H-%M-%S\'); region=$(slurp); [ -n "$region" ] && grim -g "$region" ~/Documents/learning/server+/images/"$name".png && notify-send "Screenshot-snippet saved: $name.png"\'
