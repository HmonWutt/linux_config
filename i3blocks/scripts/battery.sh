#!/bin/bash

# Battery script for i3blocks
# Save as ~/.config/i3blocks/scripts/battery

BATTERY_PATH="/sys/class/power_supply/BAT0"
ADAPTER_PATH="/sys/class/power_supply/ADP1"

# Check if battery exists
if [ ! -d "$BATTERY_PATH" ]; then
    # Try alternative battery paths
    for bat in /sys/class/power_supply/BAT*; do
        if [ -d "$bat" ]; then
            BATTERY_PATH="$bat"
            break
        fi
    done
fi

# Check if adapter exists  
if [ ! -d "$ADAPTER_PATH" ]; then
    # Try alternative adapter paths
    for adapter in /sys/class/power_supply/A{C,DP}*; do
        if [ -d "$adapter" ]; then
            ADAPTER_PATH="$adapter"
            break
        fi
    done
fi

# Exit if no battery found
if [ ! -d "$BATTERY_PATH" ]; then
    echo "No battery"
    exit 1
fi

# Read battery info
CAPACITY=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

# Check if charging
CHARGING=false
if [ -f "$ADAPTER_PATH/online" ]; then
    ADAPTER_ONLINE=$(cat "$ADAPTER_PATH/online" 2>/dev/null || echo "0")
    [ "$ADAPTER_ONLINE" = "1" ] && CHARGING=true
elif [ "$STATUS" = "Charging" ]; then
    CHARGING=true
fi

# Choose icon based on status and capacity
if $CHARGING; then
    if [ "$CAPACITY" -ge 95 ]; then
        ICON="󱈏"
    else
        ICON=""
    fi
else
    if [ "$CAPACITY" -ge 90 ]; then
        ICON="󰂁"
    elif [ "$CAPACITY" -ge 70 ]; then
        ICON="󰂁"
    elif [ "$CAPACITY" -ge 50 ]; then
        ICON="󰁿"
    elif [ "$CAPACITY" -ge 30 ]; then
        ICON="󰁽"
    elif [ "$CAPACITY" -le 29 ]; then
        ICON="󰁻"
    elif [ "$CAPACITY" -le 10 ]; then
	ICON="󰁺"
    else
        ICON=""
    fi
fi

# Format output
OUTPUT="$ICON $CAPACITY%"

# Add charging indicator
if $CHARGING; then
    OUTPUT="$OUTPUT ⚡"
fi

echo "$OUTPUT"  # Full text
echo "$OUTPUT"  # Short text

# Set color based on battery level
if [ "$CAPACITY" -ge 90 ]; then
	echo "#00FF7F"    # Spring green - excellent
elif [ "$CAPACITY" -ge 75 ]; then
        echo "#7FFF00"    # Chartreuse - very good
elif [ "$CAPACITY" -ge 60 ]; then
        echo "#ADFF2F"    # Green yellow - good
elif [ "$CAPACITY" -ge 45 ]; then
        echo "#FFFF00"    # Yellow - moderate
elif [ "$CAPACITY" -ge 30 ]; then
        echo "#FFD700"    # Gold - getting low
elif [ "$CAPACITY" -ge 20 ]; then
        echo "#FFA500"    # Orange - low
elif [ "$CAPACITY" -ge 10 ]; then
        echo "#FF4500"    # Orange red - very low
else
        echo "#FF0000"    # Red - critical
fi

# Exit codes for urgent notifications
if [ "$CAPACITY" -le 10 ] && ! $CHARGING; then
    exit 33  # Urgent block
fi
