#!/bin/bash

# Define colors (you can customize these)
COLOR_PLAY="#00ff00"     # Green for playing
COLOR_PAUSE="#ffff00"    # Yellow for paused
COLOR_STOP="#FFA500"     # Orange for no music

# Get metadata
# Get all metadata in a single call using tab delimiter
METADATA=$(playerctl metadata --format $'{{status}}\t{{artist}}\t{{title}}' 2>/dev/null)

if [ -n "$METADATA" ]; then
    STATUS=$(echo "$METADATA" | cut -d$'\t' -f1)
    ARTIST=$(echo "$METADATA" | cut -d$'\t' -f2)
    TITLE=$(echo "$METADATA" | cut -d$'\t' -f3)
else
    STATUS=""
    ARTIST=""
    TITLE=""
fi

if [ "$STATUS" = "Playing" ]; then
    ICON="󰧔"  #"󰽰"   #""
    COLOR=$COLOR_PLAY
    TEXT="$ICON $ARTIST  $TITLE"
elif [ "$STATUS" = "Paused" ]; then
    ICON="⏸"
    COLOR=$COLOR_PAUSE
    TEXT="$ICON $ARTIST  $TITLE"
else
    ICON="󰝛"
    TEXT="$ICON No music"
    COLOR=$COLOR_STOP
fi

echo "$TEXT"
echo "$TEXT"
echo "$COLOR"

