#!/bin/bash

# Define colors (you can customize these)
COLOR_PLAY="#00ff00"     # Green for playing
COLOR_PAUSE="#ffff00"    # Yellow for paused
COLOR_STOP="#FFA500"     # Orange for no music

# Get metadata
STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ]; then
    ICON="󰧔"  #"󰽰"   #""
    COLOR=$COLOR_PLAY
    ARTIST=$(playerctl metadata artist)
    TITLE=$(playerctl metadata title)
    TEXT="$ICON $ARTIST  $TITLE"
elif [ "$STATUS" = "Paused" ]; then
    ICON="⏸"
    COLOR=$COLOR_PAUSE
    ARTIST=$(playerctl metadata artist)
    TITLE=$(playerctl metadata title)
    TEXT="$ICON $ARTIST  $TITLE"
else
    ICON="󰝛"
    TEXT="$ICON No music"
    COLOR=$COLOR_STOP
fi

echo "$TEXT"
echo "$TEXT"
echo "$COLOR"

