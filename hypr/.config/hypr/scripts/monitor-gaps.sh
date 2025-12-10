#!/bin/bash

# Set preferred gaps per monitor name
# requires socat and jq as dependencies
LAPTOP="eDP-1"
LAPTOP_G_IN=3
LAPTOP_G_OUT=6

EXT="HDMI-A-1"
EXT_G_IN=3
EXT_G_OUT=9

# Listen for active monitor changes
socat - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | \
while read -r line; do
    case "$line" in
        monitor*)
            ACTIVE=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true).name')

            if [ "$ACTIVE" = "$LAPTOP" ]; then
                hyprctl keyword general:gaps_in $LAPTOP_G_IN
                hyprctl keyword general:gaps_out $LAPTOP_G_OUT
            elif [ "$ACTIVE" = "$EXT" ]; then
                hyprctl keyword general:gaps_in $EXT_G_IN
                hyprctl keyword general:gaps_out $EXT_G_OUT
            fi
            ;;
    esac
done
