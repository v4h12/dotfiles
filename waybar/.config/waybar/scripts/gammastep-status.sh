#!/bin/bash

if pgrep -x gammastep >/dev/null; then
    # Try to extract current temperature from gammastep -p
    temp=$(gammastep -p 2>/dev/null | grep -i "color temperature" | awk '{print $3}' | tr -d 'K')

    # If gammastep -p gives nothing, read from config instead
    if [ -z "$temp" ]; then
        # Adjust path if your config lives elsewhere
        config="$HOME/.config/gammastep/config.ini"
        day_temp=$(grep -i "temp-day" "$config" | awk -F= '{print $2}' | tr -d ' ')
        night_temp=$(grep -i "temp-night" "$config" | awk -F= '{print $2}' | tr -d ' ')

        # Determine whether it's day or night by time (simple fallback)
        hour=$(date +%H)
        if [ "$hour" -ge 6 ] && [ "$hour" -lt 18 ]; then
            temp="$day_temp"
            period="Daytime"
        else
            temp="$night_temp"
            period="Nighttime"
        fi
    else
        # If we got a temperature, assume day/night based on threshold
        if [ "$temp" -ge 4500 ]; then
            period="Daytime"
        else
            period="Nighttime"
        fi
    fi

    icon="󰌁"
    class="on"
    tooltip="Gammastep: On ($period ${temp}K)"
else
    icon="󰹊"
    class="off"
    tooltip="Gammastep: Off"
fi

echo "{\"text\":\"$icon\",\"class\":\"$class\",\"tooltip\":\"$tooltip\"}"
