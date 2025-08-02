#!/bin/bash

COLOUR_CONNECTED="#87CEEB"  # Light blue
COLOUR_DISCONNECTED="#FF0000"  # Red

SSID=$(iwgetid -r 2>/dev/null)

if [ "$SSID" ]; then
    TEXT=" $SSID"
    COLOR="$COLOUR_CONNECTED"
else
    TEXT="󰖪 Disconnected"
    COLOR="$COLOUR_DISCONNECTED"
fi

# i3blocks format: full_text, short_text, color
echo "$TEXT"
echo "$TEXT"
echo "$COLOR"
