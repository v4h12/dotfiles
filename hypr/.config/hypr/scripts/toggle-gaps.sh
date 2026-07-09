#!/bin/bash

DEFAULT_GIN=3
DEFAULT_GOUT=6

CURRENT=$(hyprctl -j getoption general:gaps_out | jq '.int')

if [ "$CURRENT" -eq 0 ]; then
    hyprctl keyword general:gaps_in "$DEFAULT_GIN"
    hyprctl keyword general:gaps_out "$DEFAULT_GOUT"
else
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
fi
