#!/bin/bash

# Path to your wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Pick a random image from the directory and set it as the background
feh --bg-scale "$(find "$WALLPAPER_DIR" -type f | shuf -n 1)"
