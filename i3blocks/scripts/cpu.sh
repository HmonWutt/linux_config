#!/bin/sh

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

if [ $(echo "$CPU > 80" | bc -l) -eq 1 ]; then
  COLOR="#FF5555"
elif [ $(echo "$CPU > 50" | bc -l) -eq 1 ]; then
  COLOR="#FFD700"
else
  COLOR="#8FBC8F"
fi

USAGE=$(printf "%.0f%%" "$CPU")
echo " $USAGE"
echo " $USAGE"  
echo "$COLOR"
