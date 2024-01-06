#!/bin/sh
# Change the sway workspace with a rofi menu

if [ -n "$1" ]; then
	swaymsg workspace number "$1" >/dev/null
	exit 0
fi
echo "1一"
echo "2二"
echo "3三"
echo "4四"
echo "5五"
echo "6六"
echo "7七"
echo "8八"
echo "9九"
