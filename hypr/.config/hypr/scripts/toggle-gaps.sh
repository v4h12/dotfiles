#!/bin/bash
set -e

DEFAULT_GIN=3
DEFAULT_GOUT=6

CURRENT=$(hyprctl -j getoption general:gaps_out | jq -r '.css // .int')

if [ "$CURRENT" = "0 0 0 0" ] || [ "$CURRENT" = "0" ]; then
    hyprctl eval "hl.config({ general = { gaps_in = $DEFAULT_GIN, gaps_out = $DEFAULT_GOUT } })"
else
    hyprctl eval "hl.config({ general = { gaps_in = 0, gaps_out = 0 } })"
fi
