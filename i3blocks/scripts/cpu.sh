#!/bin/sh

# Use /proc/stat for lighter CPU calculation
read cpu a1 b1 c1 idle1 rest < /proc/stat
sleep 0.1
read cpu a2 b2 c2 idle2 rest < /proc/stat

total1=$((a1+b1+c1+idle1))
total2=$((a2+b2+c2+idle2))
idle_diff=$((idle2-idle1))
total_diff=$((total2-total1))

CPU=$(awk "BEGIN {printf \"%.0f\", ($total_diff-$idle_diff)*100/$total_diff}")

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
