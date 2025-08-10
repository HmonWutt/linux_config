#!/bin/sh

# Use /proc/stat for lighter CPU calculation
read cpu a b c idle rest < /proc/stat
total=$((a+b+c+idle))
CPU=$(awk "BEGIN {printf \"%.0f\", ($total-$idle)*100/$total}")

if [ "$CPU" -gt 80 ]; then
  COLOR="#FF5555"
elif [ "$CPU" -gt 50 ]; then
  COLOR="#FFD700"
else
  COLOR="#8FBC8F"
fi

USAGE=$(printf "%.0f%%" "$CPU")
echo " $USAGE"
echo " $USAGE"  
echo "$COLOR"
