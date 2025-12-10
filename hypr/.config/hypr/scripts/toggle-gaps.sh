#!/bin/bash

STATE="$HOME/.cache/gaps_state"

# Your REAL default gaps — set these to whatever you use
DEFAULT_GIN=3
DEFAULT_GOUT=6

# Read current gaps
CURR_GIN=$(hyprctl -j getoption general:gaps_in  | jq -r '.int')
CURR_GOUT=$(hyprctl -j getoption general:gaps_out | jq -r '.int')

# If state file doesn’t exist, create it
if [ ! -f "$STATE" ]; then
    echo "on" > "$STATE"
fi

STATE_VAL=$(cat "$STATE")

if [ "$STATE_VAL" = "on" ]; then
    # Turn gaps OFF
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    echo "off" > "$STATE"
else
    # Restore exact defaults
    hyprctl keyword general:gaps_in $DEFAULT_GIN
    hyprctl keyword general:gaps_out $DEFAULT_GOUT
    echo "on" > "$STATE"
fi
