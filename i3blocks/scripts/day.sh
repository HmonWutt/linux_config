#!/bin/bash

COLOR="#8F00FF"  # purple

DAY=$(date '+%A' | tr '[:lower:]' '[:upper:]')
TEXT=" $DAY"

# i3blocks format: full_text, short_text, color
echo "$TEXT"
echo "$TEXT"
echo "$COLOR"