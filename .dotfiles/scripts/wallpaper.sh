#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jirou@kitsugo.dev>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Selects a random wallpaper from /tmp/colorscheme/wallpapers.txt with swaybg/feh. 
readonly wallpaper_dir="$HOME/.dotfiles/extra/wallpapers/"

if [ -n "$WAYLAND_DISPLAY" ]; then
	swaybg -i "$(find -L "$wallpaper_dir". -type f | shuf -n1)" -m fill &
else
	feh --no-fehbg --bg-fill --recursive --randomize "$wallpaper_dir"
fi
