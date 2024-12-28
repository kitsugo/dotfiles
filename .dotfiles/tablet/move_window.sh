#!/bin/bash
# Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Automatically fetch the previous/next sway workspace and move the current window there. Requires jq
# move_window.sh [OFFSET]
readonly numerals=("一" "二" "三" "四" "五" "六" "七" "八" "九")
next=$((($(swaymsg -t get_workspaces | jq '.[] | select(.focused).num') + $1) % 10))
[ $next -eq 0 ] && next=$((next + 1)) # Skip workspace "0"
readonly nextName=${numerals[$next - 1]}
swaymsg move container to workspace number $next"$nextName"
