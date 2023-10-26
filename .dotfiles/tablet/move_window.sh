#!/bin/bash
# Automatically fetch the previous/next sway workspace and move the current window there. Requires jq
# move_window.sh [OFFSET]
numerals=("一" "二" "三" "四" "五" "六" "七" "八" "九")
next=$((($(swaymsg -t get_workspaces | jq '.[] | select(.focused).num') + $1) % 10))
[ $next -eq 0 ] && next=$((next + 1)) # Skip workspace "0"
nextName=${numerals[$next - 1]}
swaymsg move container to workspace number $next"$nextName"
